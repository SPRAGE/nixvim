{ lib, config, ... }:

let
  # --- CONFIGURATION AREA ---
  # Define which AI models you want to enable here.
  # Just add the filename (without the .nix extension) to this list.
  enabledAiTools = [
    "copilot-lua"
    # "another-ai-tool" # Add future tools here to enable them
  ];

  # --- DYNAMIC MODULE IMPORTER ---
  # This automatically finds and imports all available AI modules in this directory
  # (e.g., copilot-lua.nix) so their options are available.
  allAvailableModules =
    let
      currentDirFiles = builtins.attrNames (builtins.readDir ./.);
      moduleFiles = builtins.filter
        (file: lib.hasSuffix ".nix" file && file != "default.nix")
        currentDirFiles;
    in
    map (file: ./${file}) moduleFiles;

in
{
  # 1. Import all available modules. This makes Nix aware of options like
  #    `ai.copilot-lua.enable` from copilot-lua.nix.
  imports = allAvailableModules;

  # 2. Automatically enable the modules listed in `enabledAiTools`.
  #    This part reads your list and generates the necessary `enable = true;`
  #    configuration for each selected tool.
  config = lib.mkMerge (map (toolName: {
    # This dynamically creates the attribute path and sets `enable` to true.
    # For "copilot-lua", it becomes: ai.copilot-lua.enable = true;
    ai.${toolName}.enable = true;
  }) enabledAiTools);
}
