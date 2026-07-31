# Aspect: monitoring -- self-contained VictoriaMetrics + VictoriaLogs + Grafana
# stack (see _monitoring/default.nix). NOT composed into any host by default —
# add `monitoring` to a host's nixos aspect list to enable it. Was disabled in
# the old tree; preserved here (with its Grafana dashboards) so it stays a
# one-liner to switch on.
{
  flake.modules.nixos.monitoring = {
    imports = [ ./_monitoring/default.nix ];
  };
}
