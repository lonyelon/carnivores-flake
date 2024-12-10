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

      carnSource = pkgs.fetchzip {
        url = "https://d1.myabandonware.com/t/70208373-9c1b-4749-a053-72d39db3ca03/Carnivores_Win_EN_RIP-Version.zip";
        hash = "sha256-VlvOOP2SOmH9Dn/5Wutrg9Bmpcza9tbXPAa+ZmqIujU=";
      };

      carn2Source = pkgs.fetchzip {
        url = "https://d1.myabandonware.com/t/2b28582f-ebc8-413c-ab73-7ea37eea6e7a/Carnivores-2_Win_EN_ISO-Version.zip";
        hash = "sha256-p5/IedESv2qcC7jKIsDnNkOKvvxP/mrjXqQ2JH9ortM=";
      };

      carn2PatchSource = pkgs.fetchurl {
        url = "https://d1.myabandonware.com/t/1b2f492e-8160-4405-8a01-63bdb5cb6660/Carnivores-2_Patch_Win_EN_Patch-v11.zip";
        hash = "sha256-h6wwvE/F7DjqrHXL+S2BNCbOXysz8n75d5ydysoJUgo=";
      };
  
  
      iceAgeSource = pkgs.fetchzip {
        url = "https://d1.myabandonware.com/t/7cc5b744-ae09-44b5-b338-8d974dab24ec/Carnivores-Ice-Age_Win_EN_ISO-Version.zip";
        hash = "sha256-uQsQ+zq63jetgEkBPdjGf866RfHIvap/GaLOQzyjdqM=";
      };

      # fetchzip won't work as the zip has many files in the root.
      iceAgePatchSource = pkgs.fetchurl {
        url = "https://d1.myabandonware.com/t/ac57712b-183a-4ca1-a9b3-17e9f8be4f17/Carnivores-Ice-Age_Patch_Win_EN_Patch-v212.zip";
        hash = "sha256-B2tu9RpADYxVz4YP3J+ePpNtbvC/EpZh9MtPTWInSC8=";
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
          isSourceIso = false;
        });

        # FIXME: mouse is inverted for some reason (maybe the savefile?).
        carn2 = (import ./commonDerivation.nix {
          inherit pkgs;
          name = "Carn2";
          gameSource = carn2Source;
          patchSource = carn2PatchSource;
          trophyFile = ./savefiles/default.sav;
          isSourceIso = true;
        });

        # FIXME: same issue as the carn2 derivation.
        carn2Dense = (import ./commonDerivation.nix {
          inherit pkgs;
          name = "Carn2";
          gameSource = carn2Source;
          patchSource = carn2PatchSource;
          trophyFile = ./savefiles/dense.sav;
          isSourceIso = true;
        });

        iceAge = (import ./commonDerivation.nix {
          inherit pkgs;
          name = "iceage";
          gameSource = iceAgeSource;
          patchSource = iceAgePatchSource;
          trophyFile = ./savefiles/default.sav;
          resFile = ./savefiles/default.txt;
          isSourceIso = true;
        });

        iceAgeDense = (import ./commonDerivation.nix {
          inherit pkgs;
          name = "iceage";
          gameSource = iceAgeSource;
          patchSource = iceAgePatchSource;
          trophyFile = ./savefiles/dense.sav;
          resFile = ./savefiles/default.txt;
          isSourceIso = true;
        });

        iceAgeSergioCustom = (import ./commonDerivation.nix {
          inherit pkgs;
          name = "iceage";
          gameSource = iceAgeSource;
          patchSource = iceAgePatchSource;
          trophyFile = ./savefiles/dense.sav;
          resFile = ./savefiles/sergioCustom.txt;
          isSourceIso = true;
        });
      };
    };
}
