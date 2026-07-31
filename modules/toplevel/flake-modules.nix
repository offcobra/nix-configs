# MANDATORY. Without this, `flake.modules` is a unique raw flake output and the
# second file defining it fails with "defined multiple times while it's
# expected to be unique". With it, flake.modules.<class>.<aspect> is a
# lazyAttrsOf deferredModule and merges across files — which is what makes the
# dendritic pattern work at all.
{ inputs, lib, ... }:
{
  imports = [ inputs.flake-parts.flakeModules.modules ];

  # flake-parts declares `flake.nixosConfigurations` (so hosts merge across
  # files), but NOT `flake.homeConfigurations`. Declare it here as a mergeable
  # lazyAttrsOf so each host file can contribute its own `wally@<host>` entry.
  options.flake.homeConfigurations = lib.mkOption {
    type = lib.types.lazyAttrsOf lib.types.raw;
    default = { };
  };
}
