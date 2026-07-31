# Self-contained monitoring stack for this workstation.
#
# Storage:   VictoriaMetrics (metrics)  +  VictoriaLogs (logs)
# Collectors: vmagent (scrapes exporters -> VictoriaMetrics)
#             node_exporter (host metrics)
#             Vector (journald -> VictoriaLogs)
# UI:        Grafana, pre-provisioned with both datasources.
#
# Everything binds to localhost; only Grafana is meant to be opened in a
# browser at http://localhost:3000 (default login admin/admin).
{ pkgs, ... }:

let
  # Listen addresses (host:port). Kept local so nothing is exposed off-box.
  vmHost  = "127.0.0.1";
  vmPort  = 8428; # VictoriaMetrics
  vlPort  = 9428; # VictoriaLogs
  nodePort = 9100; # node_exporter
  grafanaPort = 3000;

  vmUrl = "http://${vmHost}:${toString vmPort}";
  vlUrl = "http://${vmHost}:${toString vlPort}";
in
{
  ###########################################################################
  # Storage
  ###########################################################################

  # Metrics database. Also exposes a Prometheus-compatible query API that
  # Grafana talks to.
  services.victoriametrics = {
    enable = true;
    listenAddress = "${vmHost}:${toString vmPort}";
    retentionPeriod = "3"; # months
  };

  # Logs database.
  services.victorialogs = {
    enable = true;
    listenAddress = "${vmHost}:${toString vlPort}";
    extraOptions = [ "-retentionPeriod=3" ]; # months
  };

  ###########################################################################
  # Collectors / agents
  ###########################################################################

  # Host metrics (CPU, memory, disk, network, systemd, ...).
  services.prometheus.exporters.node = {
    enable = true;
    listenAddress = vmHost;
    port = nodePort;
    enabledCollectors = [ "systemd" "processes" ];
  };

  # vmagent scrapes the exporters and remote-writes into VictoriaMetrics.
  services.vmagent = {
    enable = true;
    remoteWrite.url = "${vmUrl}/api/v1/write";
    prometheusConfig = {
      global.scrape_interval = "15s";
      scrape_configs = [
        {
          job_name = "node";
          static_configs = [{
            targets = [ "${vmHost}:${toString nodePort}" ];
            labels.instance = "workstation";
          }];
        }
        {
          job_name = "victoriametrics";
          static_configs = [{ targets = [ "${vmHost}:${toString vmPort}" ]; }];
        }
        {
          job_name = "victorialogs";
          static_configs = [{ targets = [ "${vmHost}:${toString vlPort}" ]; }];
        }
        {
          job_name = "vmagent";
          static_configs = [{ targets = [ "${vmHost}:8429" ]; }];
        }
      ];
    };
  };

  # Ship the systemd journal into VictoriaLogs via Vector's Elasticsearch
  # bulk sink (VictoriaLogs speaks the ES ingestion API).
  services.vector = {
    enable = true;
    settings = {
      sources.journald = {
        type = "journald";
        current_boot_only = true;
      };
      sinks.victorialogs = {
        type = "elasticsearch";
        inputs = [ "journald" ];
        endpoints = [ "${vlUrl}/insert/elasticsearch/" ];
        mode = "bulk";
        api_version = "v8";
        healthcheck.enabled = false;
        query = {
          "_msg_field" = "message";
          "_time_field" = "timestamp";
          "_stream_fields" = "host,_SYSTEMD_UNIT,_HOSTNAME";
        };
        request.headers.AccountID = "0";
      };
    };
  };

  ###########################################################################
  # Grafana
  ###########################################################################

  services.grafana = {
    enable = true;

    settings = {
      server = {
        http_addr = vmHost;
        http_port = grafanaPort;
      };
      # Single-user local box: don't nag for anonymous access etc.
      "auth.anonymous".enabled = false;
      # Read the secret key from a file generated on first boot (below),
      # so no secret is ever committed to the repo.
      security.secret_key = "$__file{/var/lib/grafana/secret_key}";
    };

    # VictoriaLogs needs its own datasource plugin (not bundled with Grafana).
    declarativePlugins = [ pkgs.grafanaPlugins.victoriametrics-logs-datasource ];

    provision = {
      enable = true;
      # Drop any previously-provisioned copies first. Grafana 13 aborts startup
      # ("data source not found") if a provisioned datasource's uid changes
      # between runs; deleting by name first makes re-provisioning idempotent and
      # self-healing regardless of what uid an earlier run assigned.
      datasources.settings.deleteDatasources = [
        { name = "VictoriaMetrics"; orgId = 1; }
        { name = "VictoriaLogs"; orgId = 1; }
      ];
      datasources.settings.datasources = [
        {
          name = "VictoriaMetrics";
          uid = "victoriametrics";
          type = "prometheus";
          access = "proxy";
          url = vmUrl;
          isDefault = true;
        }
        {
          name = "VictoriaLogs";
          uid = "victorialogs";
          type = "victoriametrics-logs-datasource";
          access = "proxy";
          url = vlUrl;
        }
      ];
      # Load the JSON dashboards shipped alongside this module. The UIDs above
      # are referenced by datasource inside those dashboards.
      dashboards.settings.providers = [{
        name = "monitoring";
        options.path = ./dashboards;
        options.foldersFromFilesStructure = false;
      }];
    };
  };

  # Generate a persistent random Grafana secret key on first boot (used by the
  # file-provider above) instead of hard-coding one in the repo.
  systemd.services.grafana-secret-key = {
    wantedBy = [ "multi-user.target" ];
    before = [ "grafana.service" ];
    requiredBy = [ "grafana.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      install -d -m 0700 -o grafana -g grafana /var/lib/grafana
      if [ ! -s /var/lib/grafana/secret_key ]; then
        ${pkgs.openssl}/bin/openssl rand -base64 32 > /var/lib/grafana/secret_key
        chown grafana:grafana /var/lib/grafana/secret_key
        chmod 0600 /var/lib/grafana/secret_key
      fi
    '';
  };
}
