{ config, lib, ... }:

let
  # Shorthand to access the configuration options for this module.
  cfg = config.ai."copilot-chat";
in
{
  # Define the option to enable/disable the plugin.
  options.ai."copilot-chat" = {
    enable = lib.mkEnableOption "Enable Copilot Chat (CopilotC-Nvim)";
  };

  # Apply the configuration only if it's enabled.
  config = lib.mkIf cfg.enable {
    # The README specifies these dependencies.
    plugins = {
      # The base Copilot plugin is required.
      copilot-lua.enable = true;

      # Enable the chat plugin itself.
      copilot-chat = {
        enable = true;
      };
    };

    # As per the README, configuration is handled by a setup function.
    # We use `extraConfig` to call it.
    extraConfigLua = ''
      require('CopilotChat').setup {
        -- Set to true to see extensive logging
        debug = false,

        -- The system prompt to use for the chat.
        -- See the README for more examples.
        system_prompt = "You are a general AI conversation partner.",

        -- A prompt to use when asking about a selection of code.
        selection_prompt = "Briefly explain what this code does.",

        -- Prompt strategy can be "default" or "from_context".
        -- "from_context" is an experimental feature.
        prompt_strategy = "default",

        -- Window configuration for the chat panel.
        window = {
          layout = "vertical", -- "vertical", "horizontal", "float"
          width = 0.4,         -- width of the vertical window
          height = 0.8,        -- height of the horizontal window
        },
      }
    '';
  };
}
