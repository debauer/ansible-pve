{
  description = "Shell environment with python libraries managed via uv";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
    pyproject-nix = {
      url = "github:pyproject-nix/pyproject.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    uv2nix = {
      url = "github:pyproject-nix/uv2nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.pyproject-nix.follows = "pyproject-nix";
    };
    pyproject-build-systems = {
      url = "github:pyproject-nix/build-system-pkgs";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.pyproject-nix.follows = "pyproject-nix";
      inputs.uv2nix.follows = "uv2nix";
    };
  };

  outputs = { self, nixpkgs, flake-utils, uv2nix, pyproject-nix, pyproject-build-systems }:

    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;

          config.allowUnfree = true;

          overlays = [
            (final: prev:
              let
                # Load a uv workspace from a workspace root.
                # Uv2nix treats all uv projects as workspace projects.
                workspace = uv2nix.lib.workspace.loadWorkspace { workspaceRoot = ./.; };

                # Create package overlay from workspace.
                overlay = workspace.mkPyprojectOverlay {
                  # Prefer prebuilt binary wheels as a package source.
                  # Sdists are less likely to "just work" because of the metadata missing from uv.lock.
                  sourcePreference = "wheel";
                };

                pythonSet =
                  # Use base package set from pyproject.nix builders
                  (pkgs.callPackage pyproject-nix.build.packages { python = pkgs.python313; }).overrideScope
                  (nixpkgs.lib.composeManyExtensions [ pyproject-build-systems.overlays.default overlay ]);

                virtualenv = pythonSet.mkVirtualEnv "ansible-pve-python" workspace.deps.all;

              in {
                inherit virtualenv;

                ansible-pve = final.callPackage
                  ({ stdenv, glibcLocales,  hcloud, nixfmt-rfc-style,  uv, virtualenv, yq }:

                    stdenv.mkDerivation {
                      name = "ansible-pve";

                      buildInputs = [ hcloud glibcLocales nixfmt-rfc-style uv virtualenv yq ];

                      dontUsePyprojectBuild = true;
                    }
                    # ansible >= 2.14 requires a UTF-8 locale
                    # macOS doesn't have C.UTF-8
                    # see https://unix.stackexchange.com/a/574038
                    // nixpkgs.lib.optionalAttrs pkgs.stdenv.isLinux { LC_ALL = "C.UTF-8"; }
                    // nixpkgs.lib.optionalAttrs pkgs.stdenv.isDarwin {
                      LANG = "C";
                      LC_CTYPE = "UTF-8";
                    }) { };
              })
          ];
        };
      in {
        packages = rec {
          inherit (pkgs) ansible-pve;
          default = ansible-pve;
        };
      });

}
