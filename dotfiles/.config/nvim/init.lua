-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Initialize lazy with your plugins
require("lazy").setup({
  -- 1. The File Explorer (Nvim-Tree)
  {
    "nvim-tree/nvim-tree.lua",
    -- Mainline nvim-tree requires Nvim >= 0.10; this tag supports Neovim 0.9.x.
    tag = "compat-nvim-0.9",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
	view = {
   	   adaptive_size = true, -- This is the magic line
    	   width = 30,           -- This becomes the 'starting' width
  	},
        sync_root_with_cwd = true, -- Changes the tree root when you :cd
        respect_buf_cwd = true,    -- Will help find files relative to where you jumped
        update_focused_file = {
          enable = true,
          update_root = true,      -- Root follows the file if you jump via FZF
        },
      })
    end,
  },

  -- 2. A nice theme (Optional but recommended)
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  -- 3. Syntax Highlighting (Treesitter)
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- 4. Fzf-Lua (The Fuzzy Finder)
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("fzf-lua").setup({})
    end,
  },
})

-- Load the theme
vim.cmd.colorscheme "catppuccin"

-- Set leader key to space
vim.g.mapleader = " "

vim.opt.number = true          -- Show absolute line number on the current line
vim.opt.relativenumber = true  -- Show relative numbers for all other lines

-- 1. Use fzf-lua for finding files (The "Fast" way)
vim.keymap.set('n', '<leader>f', "<cmd>lua require('fzf-lua').files()<CR>", { desc = "Fzf Files" })

-- 2. Use fzf-lua for searching INSIDE files (ripgrep)
vim.keymap.set('n', '<leader>s', "<cmd>lua require('fzf-lua').live_grep()<CR>", { desc = "Fzf Grep" })

-- 3. Move the Tree Explorer to <leader>e (Explorer)
-- Replace 'NvimTreeToggle' with 'Neotree toggle' if you use neo-tree
vim.keymap.set('n', '<leader>e', ":NvimTreeToggle<CR>", { desc = "Toggle Tree" })

-- Jump to a Zoxide directory and update Nvim-Tree
vim.keymap.set("n", "<leader>z", function()
  require('fzf-lua').zoxide({
    fn_selected = function(selected)
      local path = selected[1]:match("[^%s]+%s+(.+)") -- Extract path from zoxide output
      -- vim.cmd("cd " .. path)
      -- vim.cmd("NvimTreeOpen") -- Opens/Focuses tree in the new path
      vim.api.nvim_set_current_dir(path) -- Updates Neovim's :pwd
      require("nvim-tree.api").tree.change_root(path)
      require("nvim-tree.api").tree.reload()
    end
  })
end, { desc = "Zoxide Jump" })
