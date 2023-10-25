{ lib, buildPackages, fetchFromGitHub, perl, buildLinux, structuredExtraConfig ? {}, ... } @ args:
let
  mptcpVersion = "0.96";
  modDirVersion = "5.4.170";
in
buildLinux ({
  version = "${modDirVersion}-mptcp_v${mptcpVersion}";
  inherit modDirVersion;
  ignoreConfigErrors = true;

  extraMeta = {
    branch = "5.4";
    maintainers = with lib.maintainers; [ teto layus ];
  };

  src = fetchFromGitHub {
    owner = "multipath-tcp";
    repo = "mptcp";
    rev = "6c1e3d3b8a6d1217dd05389ca1a7fb5bf5eca42a";
    sha256 = "sha256-QGO4FOX8sDFVhVF5blON6Y/sCh2J2v4BWnI/CSlt5Ds=";
  };

  structuredExtraConfig = lib.mkMerge [
    (import ./mptcp-config.nix { inherit lib; })
    structuredExtraConfig
  ];

} // args)

