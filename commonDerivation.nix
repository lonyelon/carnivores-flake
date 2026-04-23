{ pkgs
, pkgs-wine7
, name
, gameSource
, patchSource ? null
, trophyFile ? null
, resFile ? null
}: let
  unpackSourceScript = ''
    7z x ${gameSource} -y
    unshield x data1.cab
    mv Program_Executable_Files/* $out/game
  '';

  unpackPatchScript = if patchSource != null then ''
    mkdir patch
    cd patch
    unzip ${patchSource}
    mv * $out/game
  '' else "";

  copyTrophyFileScript = if trophyFile != null then ''
    find $out/game -type f -name "trophy*.sav" -exec rm {} \;
    cp ${trophyFile} $out/game/trophy00.sav
  '' else "";

  copyResFileScript = if resFile != null then ''
    rm $out/game/HUNTDAT/_RES.TXT
    cp ${resFile} $out/game/HUNTDAT/_RES.TXT
  '' else "";
in pkgs.stdenv.mkDerivation rec {
  pname = name;
  version = "1.0.0";

  src = gameSource;

  nativeBuildInputs = with pkgs; [ unzip p7zip unshield ];
  buildInputs = [ pkgs-wine7.wine pkgs.gamescope ];

  fileSystemCaseSensitivity = "caseInsensitive";

  unpackPhase = ''
    mkdir -p $out/game
  '' + unpackSourceScript + unpackPatchScript;

  installPhase = ''
    mkdir -p $out/bin
    cat > $out/bin/${name} <<EOF
    #!${pkgs.bash}/bin/bash
    cd $out/game
    exec ${pkgs.gamescope}/bin/gamescope -w 1024 -h 768 -f --force-grab-cursor --expose-wayland -- ${pkgs-wine7.wine}/bin/wine ${name}.EXE "\$@"
    EOF
    chmod +x $out/bin/${name}
  '' + copyTrophyFileScript + copyResFileScript;

  meta = {
    description = "Carnivores Ice Age game packaged with Wine 7";
    homepage = "https://blog.lony.xyz";
    license = pkgs.lib.licenses.gpl3Only;
    maintainers = with pkgs.lib.maintainers; [ lonyelon ];
    platforms = pkgs.lib.platforms.linux;
  };
}
