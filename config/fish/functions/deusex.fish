function deusex
    set -gx WINEPREFIX $HOME/.wine/deus_ex
    cd $WINEPREFIX/drive_c/Games/Deus_Ex
    wine System/DeusEx.exe
    set -u WINEPREFIX
end
