{
  config,
  helpers,
  lib,
  ...
}:
let
  inherit (config.nvix) icons;
in
{
  luaLoader.enable = false;
  dependencies = {
    gcc.enable = true;
  };

  globals = {
    mapleader = config.nvix.leader; # sets <space> as my leader key
    floating_window_options.border = config.nvix.border;
  };

  opts = {

    clipboard = "unnamedplus";
    cursorline = true;
    cursorlineopt = "number";

    pumblend = 0;
    pumheight = 10;

    expandtab = true;
    shiftwidth = 2;
    smartindent = true;
    tabstop = 2;
    softtabstop = 2;

    ignorecase = true;
    smartcase = true;
    mouse = "a";
    cmdheight = 0;

    number = true;
    relativenumber = true;
    numberwidth = 2;
    ruler = false;

    signcolumn = "yes";
    splitbelow = true;
    splitright = true;
    splitkeep = "screen";
    termguicolors = true;

    conceallevel = 2;

    undofile = true;

    wrap = false;

    virtualedit = "block";
    winminwidth = 5;
    fileencoding = "utf-8";
    list = true;
    smoothscroll = true;
    autoread = true;
    fillchars = {
      eob = " ";
    };

    updatetime = 500;
  };

  autoCmd = [
    {
      desc = "Highlight on yank";
      event = [ "TextYankPost" ];
      callback =
        helpers.mkRaw # lua
          ''
            function()
              vim.highlight.on_yank()
            end
          '';
    }
  ];

  extraLuaPackages = lp: with lp; [ luarocks ];
  extraConfigLua =
    with icons.diagnostics;
    # lua
    ''
      vim.opt.whichwrap:append("<>[]hl")
      vim.opt.listchars:append("space:·")

      -- Clipboard configuration for SSH sessions
      if vim.env.SSH_TTY then
        -- We're in an SSH session
        if vim.fn.executable('xclip') == 1 then
          vim.g.clipboard = {
            name = 'xclip',
            copy = {
              ['+'] = 'xclip -selection clipboard',
              ['*'] = 'xclip -selection primary',
            },
            paste = {
              ['+'] = 'xclip -selection clipboard -o',
              ['*'] = 'xclip -selection primary -o',
            },
            cache_enabled = 1,
          }
        elseif vim.fn.executable('xsel') == 1 then
          vim.g.clipboard = {
            name = 'xsel',
            copy = {
              ['+'] = 'xsel --clipboard --input',
              ['*'] = 'xsel --primary --input',
            },
            paste = {
              ['+'] = 'xsel --clipboard --output',
              ['*'] = 'xsel --primary --output',
            },
            cache_enabled = 1,
          }
        elseif vim.fn.executable('wl-copy') == 1 and vim.fn.executable('wl-paste') == 1 then
          vim.g.clipboard = {
            name = 'wl-clipboard',
            copy = {
              ['+'] = 'wl-copy',
              ['*'] = 'wl-copy --primary',
            },
            paste = {
              ['+'] = 'wl-paste --no-newline',
              ['*'] = 'wl-paste --no-newline --primary',
            },
            cache_enabled = 1,
          }
        else
          -- OSC 52 fallback for terminals that support it
          local function copy_to_clipboard(lines, _)
            local text = table.concat(lines, '\n')
            local base64 = vim.fn.system('base64', text):gsub('\n', '')
            io.write(string.format('\27]52;c;%s\7', base64))
          end

          local function paste_from_clipboard()
            return vim.fn.getreg('+')
          end

          vim.g.clipboard = {
            name = 'OSC 52',
            copy = {
              ['+'] = copy_to_clipboard,
              ['*'] = copy_to_clipboard,
            },
            paste = {
              ['+'] = paste_from_clipboard,
              ['*'] = paste_from_clipboard,
            },
            cache_enabled = 0,
          }
          vim.notify("Using OSC 52 for clipboard in SSH session. Make sure your terminal supports it.", vim.log.levels.INFO)
        end
      end

      -- below part set's the Diagnostic icons/colors
      local signs = {
        Hint = "${BoldHint}",
        Info = "${BoldInformation}",
        Warn = "${BoldWarning}",
        Error = "${BoldError}",
      }

      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
    '';
  imports =
    with builtins;
    with lib;
    map (fn: ./${fn}) (
      filter (fn: (fn != "default.nix" && !hasSuffix ".md" "${fn}")) (attrNames (readDir ./.))
    );
}
