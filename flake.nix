{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };

  outputs = { self, nixpkgs, nixos-wsl, ... }: {
    nixosConfigurations =
      let
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
      in
      {
        nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            nixos-wsl.nixosModules.default
            {
              programs.ssh = {
                startAgent = true;
                extraConfig = ''
                  Host *
                    AddKeysToAgent yes
                '';
              };

              system.stateVersion = "24.05";
              wsl.enable = true;

              wsl.defaultUser = "nixos";
              nix.settings.experimental-features = [ "nix-command" "flakes" ];

              environment.systemPackages = with pkgs; [
                nixpkgs-fmt
                nixpkgs-lint

                wget

                mc
                far2l

                git
                tig

                gnumake
                cmake
                gdb
                gcc
                pkgsCross.riscv64.buildPackages.gcc
                pkgsCross.riscv64-embedded.buildPackages.gcc
                perl

                # gf
                # seer

                cargo
                rustup

                file
                bat
                tokei

                qemu
                bochs
              ];

              programs.nix-ld = {
                enable = true;
                package = pkgs.nix-ld-rs; # only for NixOS 24.05
              };

            }
          ];
        };
      };
  };
}
