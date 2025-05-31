{ helpers, config, ... }:
let
  inherit (config.nvix.mkKey) mkKeymap wKeyObj;
in
{
  # Updated which-key list to include a "Chat" group
  wKeyList = [
    (wKeyObj [
      "<leader>a"
      "󰚩"
      "AI" # Changed from "ai" to "AI" for consistency
    ])
    (wKeyObj [
      "<leader>ac"
      "" # A gear or cog icon for copilot status
      "Copilot"
    ])
    (wKeyObj [
      "<leader>aC" # Note the capital C for Chat
      "" # A comment or chat bubble icon
      "Chat"
    ])
  ];

  keymaps = [
    # --- Copilot Status Toggle (Existing) ---
    (mkKeymap "n" "<leader>ac" (helpers.mkRaw # lua
      ''
        function()
          -- This ensures copilot.lua is loaded before toggling
          pcall(require, 'copilot')
          if vim.fn.exists('*Copilot') == 0 then
            print("Copilot not available")
            return
          end

          if require("copilot").is_enabled() then
            vim.cmd("Copilot disable")
            print("Copilot: Disabled")
          else
            vim.cmd("Copilot enable")
            print("Copilot: Enabled")
          end
        end
      ''
    ) "Toggle Copilot")

    # --- NEW: Copilot Chat Keymaps ---

    # Normal Mode Keymaps
    (mkKeymap "n" "<leader>aC" "<cmd>CopilotChatToggle<cr>" "Toggle Chat Panel")
    (mkKeymap "n" "<leader>aq" "<cmd>CopilotChatToggle<cr>" "Toggle Chat Panel (q for query)") # Alias for the above
    (mkKeymap "n" "<leader>ae" "<cmd>CopilotChatExplain<cr>" "Explain code")
    (mkKeymap "n" "<leader>at" "<cmd>CopilotChatTests<cr>" "Generate tests")
    (mkKeymap "n" "<leader>ad" "<cmd>CopilotChatDocs<cr>" "Generate docs")
    (mkKeymap "n" "<leader>af" "<cmd>CopilotChatFix<cr>" "Fix code")


    # Visual Mode Keymaps (for acting on selected text)
    (mkKeymap "v" "<leader>aC" "<cmd>CopilotChatToggle<cr>" "Toggle Chat Panel")
    (mkKeymap "v" "<leader>ae" "<cmd>CopilotChatExplain<cr>" "Explain selected code")
    (mkKeymap "v" "<leader>at" "<cmd>CopilotChatTests<cr>" "Generate tests for selection")
    (mkKeymap "v" "<leader>ad" "<cmd>CopilotChatDocs<cr>" "Generate docs for selection")
    (mkKeymap "v" "<leader>af" "<cmd>CopilotChatFix<cr>" "Fix selected code")
    (mkKeymap "v" "<leader>ar" "<cmd>CopilotChatReview<cr>" "Review selected code")

  ];
}
