{ pkgs, ... }: {
  fonts.packages = with pkgs; [
    jetbrains-mono
    fira-code
    iosevka
    montserrat
    ubuntu-sans
    (nerdfonts.override {
      fonts = [
        "Iosevka"
        "FiraCode"
        "JetBrainsMono"
        "UbuntuSans"
      ];
    })
  ];
}
