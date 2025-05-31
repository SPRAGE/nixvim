{ config, lib, ... }:

let
  # Shorthand to access the configuration options for this module.
  cfg = config.ai."copilot-chat";
in
{
  # Define the options that will be available. We name it "copilot-chat"
  # to match the filename and avoid conflicts with "copilot-lua".
  options.ai."copilot-chat" = {
    enable = lib.mkEnableOption "Enable Copilot Chat for Neovim";
  };

  # This part applies the actual plugin configuration, but only if
  # the 'enable' option we defined above is set to true.
  config = lib.mkIf cfg.enable {
    # IMPORTANT: CopilotChat.nvim requires copilot.lua to be enabled.
    # This ensures that if you enable the chat, the base plugin is also enabled.
    plugins.copilot-lua.enable = true;

    plugins.copilot-chat = {
      enable = true;
      # You can add further settings here if needed, for example:
      # settings = {
      #   debug = false;
      #   window = {
      #     layout = "vertical";
      #     width = 0.4;
      #   };
      # };
    };
  };
}
