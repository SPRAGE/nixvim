# AI Module 🤖
The AI module supercharges your Neovim setup by integrating powerful AI assistants directly into your workflow. It features both GitHub Copilot for real-time code completion and Copilot Chat for interactive conversations, code analysis, test generation, and more.
It's pre-configured to be seamlessly integrated with your environment, boosting your productivity from the moment you enable it.
Features 🌟
 * AI-Powered Completion: Get real-time, context-aware code suggestions from GitHub Copilot.
 * Interactive AI Chat: Open a chat panel to ask questions, refactor code, or brainstorm ideas with Copilot Chat.
 * Contextual Code Actions: Explain, review, or generate tests and documentation for your code in normal or visual mode.
 * Model Selection: Easily switch between different AI models (e.g., GPT-3.5, GPT-4) to balance speed and capability.
 * Fully Integrated: Works out-of-the-box with a rich set of pre-configured keymaps.
 * CMP Integration: Accept ghost-text suggestions with a simple keystroke.
Keymappings
The keymappings are organized under the <leader>a (for AI) prefix.
GitHub Copilot
| Keybinding | Action | Description |
|---|---|---|
| <leader>ac | Toggle Copilot | Toggles the Copilot completion engine on and off. |
| <C-Space> | Accept Suggestion | Accepts the current ghost-text suggestion from Copilot. |
Copilot Chat
These commands provide interactive access to the AI chat and its powerful code-aware actions.
| Keybinding | Mode | Action | Description |
|---|---|---|---|
| <leader>aC / <leader>aq | Normal | Toggle Chat Panel | Opens or closes the main Copilot Chat window. |
| <leader>am | Normal | Select Model | Opens a menu to choose the active AI model. |
| <leader>ae | Normal / Visual | Explain Code | Asks the AI to explain the code under the cursor or in the current selection. |
| <leader>at | Normal / Visual | Generate Tests | Asks the AI to generate tests for the current code block or selection. |
| <leader>aD | Normal / Visual | Generate Docs | Asks the AI to generate documentation for the current code block or selection. |
| <leader>aR | Normal / Visual | Review Code | Asks the AI to review the code under the cursor or in the selection for bugs or improvements. |
| <leader>aS | Normal | View Staged Code | Opens the staging buffer to view and apply AI-generated code snippets. |
> [!TIP]
> Using the Visual Mode keybindings is incredibly powerful. Select a block of code and press <leader>ae to get an explanation of just that part.
> 
Usage 🚀
This module is designed to be self-contained. To use it, simply import the ai module directory into your configuration. The specific tools (like copilot-lua and copilot-chat) are enabled within the module's default.nix file.
# In your home.nix,flake.nix, or other top-level configuration

# ...
imports = [
  # Assuming your modules are in ./modules
  ./modules/ai
];
# ...

Preview
> [!NOTE]
> This module can be integrated into any Neovim setup built with Nix and home-manager, and does not require the full Nvix configuration.
> 
