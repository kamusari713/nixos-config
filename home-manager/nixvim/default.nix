{
  programs.nixvim = {
    enable = true;

    plugins = {
      web-devicons.enable = true;

      comment.enable = true;

      nvim-autopairs.enable = true;

      wakatime.enable = true;

      vim-be-good.enable = true;

      visual-multi = {
        enable = true;

        settings = {
          maps = {
            "Find under" = "<C-n>";
          };
        };
      };

      tailwind-tools.enable = true;

      harpoon = {
        enable = true;

        enableTelescope = true;

        keymaps = {
          cmdToggleQuickMenu = "<leader>hh";

          addFile = "<leader>hm";

          navNext = "<leader>hn";

          navPrev = "<leader>hp";
        };
      };

      lsp = {
        enable = true;

        servers = {
          nil_ls.enable = true; # Nix

          ts_ls = {
            enable = true; # TS
            filetypes = [ "typescript" "typescriptreact" "typescript.tsx" ];
          };

          cssls.enable = true; # CSS

          tailwindcss.enable = true; # TailwindCSS

          html.enable = true; # HTML

          emmet_ls = {
            enable = true;
            filetypes = [ "html" "css" "scss" "javascript" "javascriptreact" "typescript" "typescriptreact" "svelte" "vue" ];
          };

          volar = {
            enable = true; # Vue
            # volar formatter indent is broken, so we disable it in favor of prettier
            onAttach.function = ''
               on_attach = function(client)
              client.server_capabilities.document_formatting = false
              client.server_capabilities.document_range_formatting = false
               end
            '';
            onAttach.override = true;
          };

          dockerls.enable = true; # Docker

          bashls.enable = true; # Bash

          pyright.enable = true; # Python

          marksman.enable = true; # Markdown

          gopls.enable = true; # Go

          graphql.enable = true; # GraphQL

          jsonls.enable = true; # JSON

          kotlin_language_server.enable = true; # Kotlin
        };

        keymaps = {
          silent = true;

          diagnostic = {
            # Navigate in diagnostics
            "<leader>k" = "goto_prev";
            "<leader>j" = "goto_next";
          };

          lspBuf = {
            gd = "definition";
            gD = "references";
            gt = "type_definition";
            gi = "implementation";
            K = "hover";
            "<F2>" = "rename";
          };
        };
      };

      lsp-format = {
        enable = true;
      };

      lsp-status = {
        enable = true;
      };

      lspkind = {
        enable = true;

        cmp = {
          enable = true;

          menu = {
            nvim_lsp = "[LSP]";
            nvim_lua = "[api]";
            path = "[path]";
            luasnip = "[snip]";
            buffer = "[buffer]";
            neorg = "[neorg]";
          };
        };
      };

      ts-autotag = {
        enable = true;

        settings = {
          opts = {
            enable_close = true;
            enable_close_on_slash = false;
            enable_rename = true;
          };
        };
      };

      none-ls = {
        enable = true;

        settings = {
          cmd = [ "bash -c nvim" ];
          debug = true;
        };

        sources = {
          code_actions = {
            statix.enable = true;
            gitsigns.enable = true;
          };

          diagnostics = {
            statix.enable = true;
            deadnix.enable = true;
            pylint.enable = true;
            checkstyle.enable = true;
          };

          formatting = {
            alejandra.enable = true;
            stylua.enable = true;
            shfmt.enable = true;
            nixpkgs_fmt.enable = true;
            google_java_format.enable = false;
            prettier = {
              enable = true;
              disableTsServerFormatter = true;
            };
            black = {
              enable = true;
              settings = ''
                {
                	extra_args = { "--fast" },
                }
              '';
            };
          };

          completion = {
            luasnip.enable = true;
            spell.enable = true;
          };
        };
      };

      luasnip = {
        enable = true;
      };

      neo-tree = {
        enable = true;

        window = {
          position = "right";
        };

        filesystem = {
          groupEmptyDirs = true;

          filteredItems = {
            hideDotfiles = false;
            hideGitignored = false;
            visible = true;
          };
        };
      };

      treesitter = {
        enable = true;

        settings = {
          ensure_installed = [
            "nix"
            "java"
            "javascript"
            "html"
            "css"
            "python"
            "lua"
          ];

          sync_install = true;

          highlight.enable = true;

          indent.enable = true;
        };
      };

      telescope = {
        enable = true;
        extensions = {
          fzf-native = {
            enable = true;
          };
        };
        settings = {
          pickers = {
            find_files = {
              hiden_files = true;
            };
          };
        };
      };

      lualine = {
        enable = true;

        settings = {
          extensions = [ "fzf" ];
          globalstatus = true;

          # +-------------------------------------------------+
          # | A | B | C                             X | Y | Z |
          # +-------------------------------------------------+

          lualine_a = [ "mode" ];
          lualine_b = [ "branch" ];
          lualine_c = [ "filename" "diff" ];

          lualine_x = [
            "diagnostics"

            {
              __raw = ''
                function()
                	local msg = ""
                	local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                	local clients = vim.lsp.get_active_clients()
                	if next(clients) == nil then
                		return msg
                	end
                	for _, client in ipairs(clients) do
                		local filetypes = client.config.filetypes
                		if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                			return client.name
                		end
                	end
                	return msg
                end
              '';
              color = {
                fg = "#ffffff";
              };
            }

            {
              __raw = ''
                function()
                	local recording_register = vim.fn.reg_recording()
                	if recording_register == "" then
                		return ""
                	else
                		return "Recording @" .. recording_register
                	end
                end
              '';
              color = {
                fg = "#ff0000";
              };
            }
            "encoding"
            "fileformat"
            "filetype"
          ];
        };
      };
    };

    defaultEditor = true;

    luaLoader.enable = true;

    globals = {
      mapleader = " ";
    };

    clipboard = {
      register = "unnamedplus";
      providers.wl-copy.enable = true;
    };

    opts = {
      tabstop = 4;
      shiftwidth = 4;
      softtabstop = 4;
      autoindent = true;

      number = true;
      relativenumber = true;
    };

    colorschemes = {
      gruvbox = {
        enable = true;
        settings = {
          transparent_mode = true;
        };
      };
    };

    keymaps = [
      # Nvim neo tree
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>Neotree<CR>";
      }
      # Telescope
      {
        mode = "n";
        key = "<leader>fd";
        action = "<cmd>Telescope live_grep<CR>";
      }
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<CR>";
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>Telescope git_commits<CR>";
      }
      # Lazygit
      {
        mode = "n";
        key = "<leader>gg";
        action = "<cmd>LazyGit<CR>";
      }
      # Commentary bindings
      {
        mode = "n";
        key = "<leader>/";
        action = "<cmd>Commentary<CR>";
      }
      # Utility
      {
        mode = "n";
        key = "<leader>o";
        action = "o<Esc>k";
      }
      {
        mode = "n";
        key = "<leader>O";
        action = "O<Esc>j";
      }
      {
        mode = "n";
        key = "<leader>s";
        action = "<cmd>w<CR>";
      }
    ];
  };
}
