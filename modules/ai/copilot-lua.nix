{ config, lib, ... }:

let
  # This is a shorthand to access the configuration options for this module.
  cfg = config.ai.copilot-lua;
in
{
  # Define the options that will be available for this module.
  options.ai.copilot-lua = {
    enable = lib.mkEnableOption "Enable GitHub Copilot for Neovim";
  };

  # This part applies the actual plugin configuration, but only if
  # the 'enable' option we defined above is set to true.
  config = lib.mkIf cfg.enable {
    plugins.copilot-lua = {
      enable = true;
      settings = {
        filetypes.markdown = true;
        suggestion = {
          enabled = true;
          auto_trigger = true;
        };
      };
    };
  };
}
