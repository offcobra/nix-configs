{ pkgs, ... }:

let
  # ---------------------------------------------------------------------------
  # SETTINGS
  #
  # VAULT_ADDR comes from the environment (see user/cli/dev-tools.nix).
  # The host inventory is read at runtime from ~/.inventory
  # (override with RJ_INVENTORY). See `rj --help`.
  # ---------------------------------------------------------------------------

  # Default vault auth method; override per shell with RJ_VAULT_METHOD.
  vaultMethod = "oidc";

  # Seconds before a copied password is wiped from the clipboard again.
  clipTtl = 45;

in
{
  home.packages = [

    # ---------------------------------------------------------------------
    # rj (remote jump) - fzf host picker -> credential from vault -> ssh
    # ---------------------------------------------------------------------
    (pkgs.writeShellApplication {
      name = "rj";

      runtimeInputs = with pkgs; [
        vault-bin
        fzf
        jq
        openssh
        coreutils
        gawk
        wl-clipboard
        xclip
        gnugrep
        glibc.bin   # iconv, for the UTF-16LE clip.exe hand-off
      ];

      text = /*bash*/ ''
        umask 077

        VAULT_METHOD="''${RJ_VAULT_METHOD:-${vaultMethod}}"
        VAULT_ROLE="''${RJ_VAULT_ROLE:-}"
        CLIP_TTL="''${RJ_CLIP_TTL:-${toString clipTtl}}"
        INVENTORY="''${RJ_INVENTORY:-$HOME/.inventory}"

        HOSTS_TSV=""
        AGENT_DIR=""
        AGENT_PID=""
        JUMP_SPEC=""
        JUMP_TOKENS=()
        JUMP_NEEDS_VAULT=0
        JUMP_HAS_KEY=0
        SECRET=""

        info() { printf '#=> %s\n' "$*" >&2; }
        warn() { printf '#=> WARN: %s\n' "$*" >&2; }
        die()  { printf '#=> ERROR: %s\n' "$*" >&2; exit 1; }

        # invoked via trap, not called directly
        # shellcheck disable=SC2329
        cleanup() {
          if [ -n "$AGENT_PID" ]; then
            kill "$AGENT_PID" 2>/dev/null || true
          fi
          if [ -n "$AGENT_DIR" ] && [ -d "$AGENT_DIR" ]; then
            rm -rf "$AGENT_DIR"
          fi
        }
        trap cleanup EXIT INT TERM

        usage() {
          cat <<'USAGE'
        rj (remote jump) - pick a host, get its credential, connect.

          rj                 fzf picker, then ssh
          rj <host>          skip the picker
          rj -l|--list       list the hosts in the inventory
          rj -h|--help       this text

        Connecting to an auth=password host always puts that password on the
        clipboard first, so it can be pasted at ssh's prompt. It is wiped
        again after RJ_CLIP_TTL seconds.

        Inventory (default ~/.inventory, JSON object keyed by host name):

          {
            "prod-web-01": {
              "address":   "10.0.1.10",
              "user":      "root",
              "vaultPath": "kv/ssh/prod-web-01"
            },

            "prod-db-01": {
              "address":       "10.0.2.20",
              "auth":          "password",
              "vaultPath":     "secret/infra/db/prod-db-01",
              "userField":     "username",
              "passwordField": "password"
            },

            "plain-box": {
              "address": "10.9.0.4",
              "user":    "paul"
            },

            "lab-box": {
              "address":      "10.9.0.5",
              "user":         "paul",
              "identityFile": "~/.ssh/id_ed25519"
            },

            "deep-db": {
              "address":   "10.0.9.9",
              "user":      "admin",
              "vaultPath": "secret/infra/db/deep-db",
              "jump":      ["bastion-eu", "relay.corp.example"]
            }
          }

        Fields:
          address        required
          user           required, unless userField is given
          auth           "vault", "password" or "local"; inferred when absent
          vaultPath      required for auth vault/password; full path incl. mount
          keyField       auth=vault only, default "private_key"
          passwordField  auth=password only, default "password"
          userField      reads the ssh user from vault instead of "user"
          identityFile   auth=local only, optional ssh key file
          port           default 22
          jump           string, or array of strings, for one or more hops

        auth is inferred from the entry when not given: a vaultPath means
        "vault", no vaultPath means "local". So the smallest useful entry is
        just address + user, and that connects with plain ssh.

        auth=vault    private key pulled from vault into a scoped ssh-agent.
        auth=password vault holds a password; it is copied to the clipboard
                      and ssh prompts for it.
        auth=local    your own ssh credentials - identityFile if given,
                      otherwise whatever ssh would do on its own. Vault is
                      never contacted.

        jump entries naming another inventory host expand to user@address[:port],
        and an auth=vault hop has its key loaded too. Anything else is passed to
        ssh -J verbatim. List the full chain; a hop's own "jump" is not followed.

        Environment:
          VAULT_ADDR              the vault to talk to; required, taken from
                                  the environment
          RJ_INVENTORY=<path>     inventory file (default: ~/.inventory)
          RJ_VAULT_METHOD=<m>     vault auth method (default: oidc)
          RJ_VAULT_ROLE=<role>    auth role, if the mount has no default one
                                  ("Unable to authorize role \"\"")
          RJ_CLIP_TTL=<seconds>   clipboard wipe delay (0 disables)

        Clipboard backend is picked in this order: wl-copy (needs
        WAYLAND_DISPLAY), xclip (needs DISPLAY), clip.exe (WSL), then an
        OSC 52 escape to the terminal. wl/x backends only wipe the clipboard
        if it still holds the copied password; the others wipe unconditionally.

        USAGE
        }

        # -------------------------------------------------------------------
        # inventory
        # -------------------------------------------------------------------
        load_inventory() {
          if [ ! -f "$INVENTORY" ]; then
            die "no inventory at $INVENTORY (see: rj --help)"
          fi
          if ! jq -e . "$INVENTORY" >/dev/null 2>&1; then
            die "$INVENTORY is not valid JSON"
          fi
          if ! jq -e 'type == "object"' "$INVENTORY" >/dev/null 2>&1; then
            die "$INVENTORY must be a JSON object keyed by host name"
          fi

          local problems line
          problems="$(jq -r '
            def s(f): ((f // "") | tostring);

            to_entries[]
            | .key as $n | .value as $h
            | if ($h | type) != "object" then
                "host \($n): value must be an object"
              else
                ($h.auth // (if s($h.vaultPath) != "" then "vault" else "local" end)) as $a
                | (
                    ( if s($h.address) == "" then
                        "host \($n): missing required field address" else empty end ),

                    ( if s($h.user) == "" and s($h.userField) == "" then
                        "host \($n): needs user, or userField to read it from vault"
                      else empty end ),

                    ( if ($a != "vault" and $a != "password" and $a != "local") then
                        "host \($n): auth must be vault, password or local (got \($a))"
                      elif $a == "local" then
                        ( ( if s($h.vaultPath) != "" then
                              "host \($n): vaultPath is meaningless with auth=local"
                            else empty end ),
                          ( if s($h.userField) != "" then
                              "host \($n): userField needs a vaultPath, not valid with auth=local"
                            else empty end ) )
                      else
                        ( if s($h.vaultPath) == "" then
                            "host \($n): missing required field vaultPath (auth=\($a))"
                          else empty end )
                      end ),

                    ( if s($h.keyField) != "" and $a != "vault" then
                        "host \($n): keyField is only valid with auth=vault" else empty end ),

                    ( if s($h.passwordField) != "" and $a != "password" then
                        "host \($n): passwordField is only valid with auth=password" else empty end ),

                    ( if s($h.identityFile) != "" and $a != "local" then
                        "host \($n): identityFile is only valid with auth=local" else empty end ),

                    ( if (s($h.identityFile) | endswith(".pub")) then
                        "host \($n): identityFile \($h.identityFile) is a public key; ssh -i needs the private key (drop the .pub)"
                      else empty end ),

                    ( if ($h.jump // null) == null then empty
                      elif ($h.jump | type) == "string" then empty
                      elif ($h.jump | type) == "array" then
                        ( if ($h.jump | any(type != "string")) then
                            "host \($n): jump array must contain only strings"
                          else empty end )
                      else "host \($n): jump must be a string or an array of strings"
                      end )
                  )
              end
          ' "$INVENTORY")"

          if [ -n "$problems" ]; then
            while IFS= read -r line; do
              printf '#=> ERROR: %s\n' "$line" >&2
            done <<<"$problems"
            die "fix $INVENTORY and retry"
          fi

          HOSTS_TSV="$(jq -r '
            to_entries[]
            | [ .key,
                .value.address,
                (.value.user // "-"),
                ((.value.port // 22) | tostring),
                (.value.vaultPath // "-"),
                (.value.keyField // "private_key"),
                ( if (.value.jump // null) == null then "-"
                  elif (.value.jump | type) == "array" then
                    ( if (.value.jump | length) == 0 then "-"
                      else (.value.jump | join(",")) end )
                  else .value.jump end ),
                (.value.auth
                 // (if ((.value.vaultPath // "") | tostring) != "" then "vault"
                     else "local" end)),
                (.value.identityFile // "-"),
                (.value.passwordField // "password"),
                (.value.userField // "-")
              ] | @tsv
          ' "$INVENTORY")"

          [ -n "$HOSTS_TSV" ] || die "$INVENTORY contains no hosts"
        }

        row_for() {
          awk -F'\t' -v n="$1" '$1 == n { print; exit }' <<<"$HOSTS_TSV"
        }

        field_of() {
          awk -F'\t' -v i="$2" '{ print $i }' <<<"$1"
        }

        list_hosts() {
          awk -F'\t' \
            'BEGIN { printf "%-20s %-17s %-16s %-5s %-9s %-26s %s\n",
                            "HOST","ADDRESS","USER","PORT","AUTH","CREDENTIAL","JUMP" }
             { usr  = ($11 == "-") ? $3 : ("vault:" $11)
               cred = ($8 == "local") ? (($9 == "-") ? "(ssh defaults)" : $9) : $5
               printf "%-20s %-17s %-16s %-5s %-9s %-26s %s\n", $1, $2, usr, $4, $8, cred, $7 }' \
            <<<"$HOSTS_TSV"
        }

        pick_host() {
          awk -F'\t' \
            '{ usr  = ($11 == "-") ? $3 : ("vault:" $11)
               cred = ($8 == "local") ? (($9 == "-") ? "(ssh defaults)" : $9) : $5
               printf "%-20s %-17s %-16s %-9s %s\n", $1, $2, usr, $8, cred }' \
            <<<"$HOSTS_TSV" \
          | fzf --prompt='rj > ' \
              --height=40% \
              --reverse \
              --no-multi \
              --header='HOST                 ADDRESS           USER             AUTH      CREDENTIAL' \
          | awk '{ print $1 }'
        }

        # Collect the hops now; the actual -J spec can only be built once vault
        # is reachable, because a hop may read its username from vault.
        collect_jumps() {
          local raw="$1" tok jrow
          JUMP_TOKENS=()
          JUMP_NEEDS_VAULT=0
          JUMP_HAS_KEY=0
          [ "$raw" != "-" ] || return 0

          local -a toks
          IFS=',' read -r -a toks <<<"$raw"
          for tok in "''${toks[@]}"; do
            # read with default IFS trims surrounding whitespace
            read -r tok <<<"$tok" || true
            [ -n "$tok" ] || continue
            JUMP_TOKENS+=( "$tok" )

            jrow="$(row_for "$tok")"
            [ -n "$jrow" ] || continue
            if [ "$(field_of "$jrow" 8)" = "vault" ]; then
              JUMP_HAS_KEY=1
              JUMP_NEEDS_VAULT=1
            fi
            if [ "$(field_of "$jrow" 11)" != "-" ]; then
              JUMP_NEEDS_VAULT=1
            fi
          done
        }

        build_jump_spec() {
          local tok jrow specs=()
          local j_name j_addr j_user j_port j_path j_field j_jump j_auth j_id j_pw j_uf
          JUMP_SPEC=""
          [ "''${#JUMP_TOKENS[@]}" -gt 0 ] || return 0

          for tok in "''${JUMP_TOKENS[@]}"; do
            jrow="$(row_for "$tok")"
            if [ -z "$jrow" ]; then
              specs+=( "$tok" )
              continue
            fi

            # j_id and j_pw are positional placeholders
            # shellcheck disable=SC2034
            IFS=$'\t' read -r j_name j_addr j_user j_port j_path j_field j_jump \
                              j_auth j_id j_pw j_uf <<<"$jrow"

            if [ "$j_jump" != "-" ]; then
              warn "jump host $j_name has its own jump field - not followed, list the full chain"
            fi
            if [ "$j_uf" != "-" ]; then
              j_user="$(vault kv get -field="$j_uf" "$j_path")" \
                || die "could not read $j_uf from $j_path"
            fi
            if [ "$j_auth" = "vault" ]; then
              load_key "$j_path" "$j_field"
            fi

            if [ "$j_port" = "22" ]; then
              specs+=( "$j_user@$j_addr" )
            else
              specs+=( "$j_user@$j_addr:$j_port" )
            fi
          done

          JUMP_SPEC="$( IFS=','; printf '%s' "''${specs[*]}" )"
        }

        # -------------------------------------------------------------------
        # clipboard
        # -------------------------------------------------------------------
        # WSLg mirrors the Windows clipboard into Wayland and treats Windows as
        # authoritative: `wl-copy --clear` returns 0 but the old value is synced
        # straight back. So on WSL the Windows clipboard is the only one that
        # actually clears, and it has to be probed before WAYLAND_DISPLAY.
        is_wsl() {
          [ -n "''${WSL_DISTRO_NAME:-}" ] && return 0
          grep -qi microsoft /proc/version 2>/dev/null
        }

        clip_backend() {
          if is_wsl && command -v clip.exe >/dev/null 2>&1; then
            printf 'wsl'
          elif [ -n "''${WAYLAND_DISPLAY:-}" ] && command -v wl-copy >/dev/null 2>&1; then
            printf 'wl'
          elif [ -n "''${DISPLAY:-}" ] && command -v xclip >/dev/null 2>&1; then
            printf 'xclip'
          elif command -v clip.exe >/dev/null 2>&1; then
            printf 'wsl'
          else
            printf 'osc52'
          fi
        }

        # secret on stdin, never as an argument (argv is world readable in ps)
        #
        # wl-copy and xclip fork a daemon that serves the selection. Without
        # detaching its stdio it inherits ours and keeps the pipe open, so
        # piping rj's output would never see EOF.
        clip_write() {
          case "$1" in
            # clip.exe decodes stdin as the OEM codepage, which mangles any
            # non-ascii byte. It does accept UTF-16LE, so convert first.
            wsl)   iconv -f UTF-8 -t UTF-16LE | clip.exe >/dev/null 2>&1 ;;
            wl)    wl-copy >/dev/null 2>&1 ;;
            xclip) xclip -selection clipboard >/dev/null 2>&1 ;;
            osc52)
              local b64
              b64="$(base64 -w0)"
              [ -w /dev/tty ] || return 1
              printf '\033]52;c;%s\a' "$b64" > /dev/tty
              ;;
          esac
        }

        # Echoes the current clipboard, or returns 1 if this backend cannot read.
        clip_read() {
          case "$1" in
            wsl)
              # Prefer wl-paste: under WSLg it reads the same windows-synced
              # clipboard and returns correct utf-8. powershell detached from a
              # console decodes via the OEM codepage and mangles any non-ascii
              # byte, which would make the compare below always fail and leave
              # the password sitting on the clipboard forever.
              if [ -n "''${WAYLAND_DISPLAY:-}" ] && command -v wl-paste >/dev/null 2>&1; then
                wl-paste --no-newline 2>/dev/null
              elif command -v powershell.exe >/dev/null 2>&1; then
                powershell.exe -NoProfile -NonInteractive -Command Get-Clipboard 2>/dev/null \
                  | tr -d '\r'
              else
                return 1
              fi
              ;;
            wl)
              command -v wl-paste >/dev/null 2>&1 || return 1
              wl-paste --no-newline 2>/dev/null
              ;;
            xclip) xclip -selection clipboard -o 2>/dev/null ;;
            *)     return 1 ;;
          esac
        }

        clip_clear() {
          case "$1" in
            wsl)   printf "" | clip.exe >/dev/null 2>&1 || true ;;
            wl)    wl-copy --clear >/dev/null 2>&1 || true ;;
            xclip) printf "" | xclip -selection clipboard >/dev/null 2>&1 || true ;;
            osc52) if [ -w /dev/tty ]; then printf '\033]52;c;\a' > /dev/tty; fi ;;
          esac
        }

        arm_clip_clear() {
          local backend="$1" ttl="$2"
          [ "$ttl" -gt 0 ] 2>/dev/null || return 0

          # $SECRET is inherited as a shell variable, not exported and not in
          # argv, so it stays out of /proc/<pid>/{cmdline,environ}.
          (
            trap - EXIT INT TERM
            sleep "$ttl"
            # Only wipe if the clipboard still holds what we put there, so a
            # later copy by the user is not destroyed. Backends that cannot be
            # read back are wiped unconditionally - the ttl promise wins.
            if current="$(clip_read "$backend")"; then
              [ "$current" = "$SECRET" ] || exit 0
            fi
            clip_clear "$backend"
          ) >/dev/null 2>&1 &
          disown 2>/dev/null || true
        }

        # -------------------------------------------------------------------
        # vault
        # -------------------------------------------------------------------
        vault_login() {
          [ -n "''${VAULT_ADDR:-}" ] \
            || die "VAULT_ADDR is not set - export it (see user/cli/dev-tools.nix)"

          if vault token lookup >/dev/null 2>&1; then
            return 0
          fi

          local args=( -method="$VAULT_METHOD" )
          if [ -n "$VAULT_ROLE" ]; then
            args+=( "role=$VAULT_ROLE" )
          fi

          info "no valid vault token - logging in to $VAULT_ADDR via $VAULT_METHOD"
          if ! vault login "''${args[@]}" >/dev/null; then
            if [ -z "$VAULT_ROLE" ]; then
              warn "if the error mentions role \"\", this mount has no default role"
              warn "set RJ_VAULT_ROLE=<role> (same as: vault login -method=$VAULT_METHOD role=<role>)"
            fi
            die "vault login failed"
          fi
        }

        start_agent() {
          AGENT_DIR="$(mktemp -d "''${XDG_RUNTIME_DIR:-/tmp}/rj.XXXXXX")"
          eval "$(ssh-agent -a "$AGENT_DIR/agent.sock" -s)" >/dev/null
          AGENT_PID="''${SSH_AGENT_PID:-}"
          [ -n "$AGENT_PID" ] || die "could not start a scoped ssh-agent"
        }

        # auth=password hosts: put the password on the clipboard so it can be
        # pasted at ssh's prompt. A clipboard failure is not fatal - it still
        # beats refusing to connect, the password can be typed.
        copy_password() {
          SECRET="$(vault kv get -field="$h_pwfield" "$h_path")" \
            || die "could not read $h_pwfield from $h_path"
          [ -n "$SECRET" ] || die "$h_path/$h_pwfield is empty"

          local backend
          backend="$(clip_backend)"
          if ! printf '%s' "$SECRET" | clip_write "$backend"; then
            warn "could not write to the clipboard via $backend - type the password instead"
            return 0
          fi

          if [ "$CLIP_TTL" -gt 0 ] 2>/dev/null; then
            arm_clip_clear "$backend" "$CLIP_TTL"
            info "password on the clipboard via $backend, wiped in ''${CLIP_TTL}s - paste at the prompt"
          else
            warn "password on the clipboard via $backend - wipe disabled, it stays until overwritten"
          fi
        }

        # The key is piped straight from vault into the agent. It is never
        # written to disk, not even to tmpfs.
        load_key() {
          info "fetching $2 from $1"
          { vault kv get -field="$2" "$1"; printf '\n'; } | ssh-add - \
            || die "could not load the key from $1 into the agent"
        }

        # -------------------------------------------------------------------
        # main
        # -------------------------------------------------------------------
        do_list=0
        target=""

        while [ $# -gt 0 ]; do
          case "$1" in
            -h|--help) usage; exit 0 ;;
            -l|--list) do_list=1; shift ;;
            --)        shift; break ;;
            -*)        die "unknown option '$1' (see: rj --help)" ;;
            *)
              [ -z "$target" ] || die "more than one host given: '$target' and '$1'"
              target="$1"; shift ;;
          esac
        done
        if [ $# -gt 0 ]; then
          target="$1"
        fi

        load_inventory

        if [ "$do_list" = "1" ]; then
          list_hosts
          exit 0
        fi

        if [ -z "$target" ]; then
          target="$(pick_host || true)"
        fi
        [ -n "$target" ] || { info "no host selected"; exit 0; }

        row="$(row_for "$target")"
        [ -n "$row" ] || die "unknown host '$target' (see: rj --list)"

        IFS=$'\t' read -r h_name h_addr h_user h_port h_path h_field h_jump \
                          h_auth h_id h_pwfield h_userfield <<<"$row"

        # ---- connect mode ----
        collect_jumps "$h_jump"

        needs_vault=0
        if [ "$h_auth" = "vault" ] || [ "$h_auth" = "password" ] \
           || [ "$h_userfield" != "-" ] || [ "$JUMP_NEEDS_VAULT" = "1" ]; then
          needs_vault=1
        fi

        needs_agent=0
        if [ "$h_auth" = "vault" ] || [ "$JUMP_HAS_KEY" = "1" ]; then
          needs_agent=1
        fi

        if [ "$needs_vault" = "1" ]; then
          vault_login
          if [ "$needs_agent" = "1" ]; then
            start_agent
          fi
          if [ "$h_userfield" != "-" ]; then
            h_user="$(vault kv get -field="$h_userfield" "$h_path")" \
              || die "could not read $h_userfield from $h_path"
          fi
        fi

        case "$h_auth" in
          local)
            info "auth=local - using your ssh credentials, vault not contacted"
            ;;
          password)
            copy_password
            ;;
        esac

        build_jump_spec

        if [ "$h_auth" = "vault" ]; then
          load_key "$h_path" "$h_field"
        fi

        ssh_args=( -p "$h_port" )

        if [ -n "$AGENT_DIR" ]; then
          ssh_args+=( -o "IdentityAgent=$AGENT_DIR/agent.sock" -o "IdentitiesOnly=no" )
        fi

        if [ "$h_auth" = "local" ] && [ "$h_id" != "-" ]; then
          if [ "''${h_id#\~/}" != "$h_id" ]; then
            h_id="$HOME/''${h_id#\~/}"
          fi
          [ -r "$h_id" ] || die "identityFile $h_id is not readable"
          # A public key here yields 'invalid format' and, with IdentitiesOnly,
          # leaves ssh with no identity at all - catch it with a clear message.
          if head -n1 "$h_id" | grep -qE '^(ssh-|ecdsa-sha2-|sk-ssh-|sk-ecdsa-)'; then
            die "identityFile $h_id is a public key; ssh -i needs the private key (try ''${h_id%.pub})"
          fi
          ssh_args+=( -i "$h_id" )
          # Without an agent in play, pin ssh to exactly this key.
          if [ -z "$AGENT_DIR" ]; then
            ssh_args+=( -o "IdentitiesOnly=yes" )
          fi
        fi

        if [ -n "$JUMP_SPEC" ]; then
          info "via jump $JUMP_SPEC"
          ssh_args+=( -J "$JUMP_SPEC" )
        fi

        info "connecting to $h_name ($h_user@$h_addr:$h_port)"

        rc=0
        # SC2029: this is the ssh destination, not a remote command
        # shellcheck disable=SC2029
        ssh "''${ssh_args[@]}" "$h_user@$h_addr" || rc=$?
        exit "$rc"
      '';
    })
  ];
}
