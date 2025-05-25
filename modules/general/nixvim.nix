{ lib, pkgs, ... }:
{

  performance.byteCompileLua = {
    enable = true;
    plugins = true;
    nvimRuntime = true;
  };

  vimAlias = true; # Enable vim alias to run nvim

  # Ensure clipboard tools are available for SSH sessions
  extraPackages = with pkgs; [
    xclip  # X11 clipboard tool
    xsel   # Alternative X11 clipboard tool
    wl-clipboard  # Wayland clipboard tool
  ];

  # If using wayland will ensure that wl-copy is enabled
  clipboard.providers.wl-copy.enable = lib.elem pkgs.system [
    "x86_64-linux"
    "aarch64-linux"
  ];

}
