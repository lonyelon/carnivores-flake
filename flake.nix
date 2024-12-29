{
  description = "Run the original Carnivores Ice Age game from 2001.";

  inputs = {
    # This revision of NixPkgs is required because it provides Wine 7.
    nixpkgs.url = "github:NixOS/nixpkgs/e3945057be467f32028ff6b67403be08285ad8c8";
  };

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux"; # Adjust if you're on a different system
      pkgs = import nixpkgs { inherit system; };

      carnSource = pkgs.fetchurl {
        url = "https://archive.org/download/carnivores_game_1998/Carnivores.iso";
        hash = "sha256-pqSOZAq5SEX9jdb8TxL1qJ9GKpkk5Dorq80277OF6Qc=";
      };

      carn2Source = pkgs.fetchurl {
        url = "https://archive.org/download/carnivores2_game_1999/Carnivores2.iso";
        hash = "sha256-HIacRroeoQ3d8wnGnpeN1waTxyt2VUXo6cfrwX93RtU=";
      };

      iceAgeSource = pkgs.fetchurl {
        url = "https://archive.org/download/img-20200723-0002/Carnivores%20Ice%20Age.iso";
        hash = "sha256-zHyXUBlTfuuUtD/QRWF6UlI8CBWieFx1NC6TqMi54fc=";
      };
    in
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
      packages.${system} = {
        # TODO Add the infinite money patch to this one too.
        carn1 = (import ./commonDerivation.nix {
          inherit pkgs;
          name = "HUNTSOFT";
          gameSource = carnSource;
          trophyFile = ./savefiles/carn1.sav;
          isSourceIso = true;
        });

        # FIXME: mouse is inverted for some reason (maybe the savefile?).
        carn2 = (import ./commonDerivation.nix {
          inherit pkgs;
          name = "Carn2";
          gameSource = carn2Source;
          trophyFile = ./savefiles/carn2.sav;
          isSourceIso = true;
        });

        # FIXME: same issue as the carn2 derivation.
        carn2Dense = (import ./commonDerivation.nix {
          inherit pkgs;
          name = "Carn2";
          gameSource = carn2Source;
          trophyFile = ./savefiles/carn2Dense.sav;
          isSourceIso = true;
        });

        iceAge = (import ./commonDerivation.nix {
          inherit pkgs;
          name = "iceage";
          gameSource = iceAgeSource;
          trophyFile = ./savefiles/iceAge.sav;
          resFile = ./savefiles/iceAge.txt;
          isSourceIso = true;
        });

        iceAgeDense = (import ./commonDerivation.nix {
          inherit pkgs;
          name = "iceage";
          gameSource = iceAgeSource;
          trophyFile = ./savefiles/iceAgeDense.sav;
          resFile = ./savefiles/iceAge.txt;
          isSourceIso = true;
        });

        iceAgeSergioCustom = (import ./commonDerivation.nix {
          inherit pkgs;
          name = "iceage";
          gameSource = iceAgeSource;
          trophyFile = ./savefiles/iceAgeDense.sav;
          resFile = ./savefiles/iceAgeSergioCustom.txt;
          isSourceIso = true;
        });
      };
    };
}
