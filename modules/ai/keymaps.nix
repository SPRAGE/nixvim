{ helpers, config, ... }:
let
  inherit (config.nvix.mkKey) mkKeymap wKeyObj;
in
{
  # Updated which-key list to include a "Model" entry.
  wKeyList = [
    (wKeyObj [ "<leader>a"  "󰚩" "AI" ])
    (wKeyObj [ "<leader>ac" "" "Copilot" ])
    (wKeyObj [ "<leader>aC" "" "Chat" ])
    (wKeyObj [ "<leader>am" "" "Model" ]) # <-- NEW: Keymap for selecting models
  ];

  keymaps = [
    # --- Copilot Status Toggle (Unchanged) ---
    (mkKeymap "n" "<leader>ac" (helpers.mkRaw # lua
      ''
        function()
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

    # --- Copilot Chat Keymaps (with the new key) ---

    # Normal Mode Keymaps
    (mkKeymap "n" "<leader>aC"  "<cmd>CopilotChatOpen<cr>"        "Open Chat")
    (mkKeymap "n" "<leader>aq"  "<cmd>CopilotChatOpen<cr>"        "Open Chat (Query)")
    (mkKeymap "n" "<leader>ae"  "<cmd>CopilotChatExplain<cr>"     "Explain code")
    (mkKeymap "n" "<leader>at"  "<cmd>CopilotChatTests<cr>"       "Generate tests")
    (mkKeymap "n" "<leader>aR"  "<cmd>CopilotChatReview<cr>"      "Review code")
    (mkKeymap "n" "<leader>aD"  "<cmd>CopilotChatDocs<cr>"        "Generate docs")
    (mkKeymap "n" "<leader>aS"  "<cmd>CopilotChatStaging<cr>"     "View/Use Staged Code")
    (mkKeymap "n" "<leader>am"  "<cmd>CopilotChat models<cr>"     "Select Model") # <-- NEW

    # Visual Mode Keymaps (act on selected text)
    (mkKeymap "v" "<leader>aC"  "<cmd>CopilotChatOpen<cr>"        "Open Chat with selection")
    (mkKeymap "v" "<leader>ae"  "<cmd>CopilotChatExplain<cr>"     "Explain selection")
    (mkKeymap "v" "<leader>at"  "<cmd>CopilotChatTests<cr>"       "Tests for selection")
    (mkKeymap "v" "<leader>aR"  "<cmd>CopilotChatReview<cr>"      "Review selection")
    (mkKeymap "v" "<leader>aD"  "<cmd>CopilotChatDocs<cr>"        "Docs for selection")
  ];
}
