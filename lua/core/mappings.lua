local builtin = require("telescope.builtin")
local comment = require("Comment.api")
local ls = require("luasnip")
local M = {}
local resize_active = false
local original_statusline = nil
local function update_statusline(msg)
  vim.opt.statusline = msg
end
local function start_resize_mode()
  if resize_active then
    return
  end
  resize_active = true

  original_statusline = vim.opt.statusline:get()
  update_statusline("🔧 RESIZE MODE: j/k = height, h/l = width, Esc = exit")
  local opts = { noremap = true, silent = true }

  vim.keymap.set("n", "j", function()
    vim.cmd("resize +2")
  end, opts)
  vim.keymap.set("n", "k", function()
    vim.cmd("resize -2")
  end, opts)
  vim.keymap.set("n", "h", function()
    vim.cmd("vertical resize -2")
  end, opts)
  vim.keymap.set("n", "l", function()
    vim.cmd("vertical resize +2")
  end, opts)
  vim.keymap.set("n", "<Esc>", stop_resize_mode, opts)
end

function stop_resize_mode()
  if not resize_active then
    return
  end
  resize_active = false
  if original_statusline then
    update_statusline(original_statusline)
  end
  vim.keymap.del("n", "j")
  vim.keymap.del("n", "k")
  vim.keymap.del("n", "h")
  vim.keymap.del("n", "l")
  vim.keymap.del("n", "<Esc>")
end
M.general = {
  ["i"] = {
    -- go to  beginning and end
    ["<C-b>"] = { "<ESC>^i", "Beginning of line" },
    ["<C-e>"] = { "<End>", "End of line" },

    -- navigate within insert mode
    ["<C-h>"] = { "<Left>", "Move left" },
    ["<C-l>"] = { "<Right>", "Move right" },
    ["<C-j>"] = { "<Down>", "Move down" },
    ["<C-k>"] = { "<Up>", "Move up" },
    -- snippets
    ["<C-y>"] = {
      function()
        ls.expand()
      end,
      "Expand Snippet",
    },
    ["<C-n>"] = {
      function()
        ls.jump(1)
      end,
      "Next snippet",
    },
    ["<C-p>"] = {
      function()
        ls.jump(-1)
      end,
      "Previous Snippet",
    },
    ["<C-d>"] = {
      function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end,
      "Change choice",
    },
  },

  ["n"] = {
    ["<Esc>"] = { "<cmd> noh <CR>", "Clear highlights" },
    ["<C-x>"] = { "<cmd> q <CR>", "Quit/Close" },
    -- Window related mappings
    ["<C-h>"] = { "<C-w>h", "Window left" },
    ["<C-l>"] = { "<C-w>l", "Window right" },
    ["<C-j>"] = { "<C-w>j", "Window down" },
    ["<C-k>"] = { "<C-w>k", "Window up" },

    -- save
    ["<C-s>"] = { "<cmd> w <CR>", "Save file" },

    -- Copy all
    ["<C-c>"] = { "<cmd> %y+ <CR>", "Copy whole file" },

    -- comments

    ["<leader>/"] = { comment.toggle.linewise.current, "Comments current line" },

    -- Buffer and tabs related mappings
    ["<leader>b"] = { "<cmd> enew <CR>", "New buffer" },
    ["<leader>x"] = { "<cmd> bdelete <CR>", "Close buffer" },
    ["K"] = { "<cmd>BufferLineCycleNext<CR>", "Go to next buffer" },
    ["J"] = { "<cmd>BufferLineCyclePrev<CR>", "Go to previous buffer" },

    ["<leader>th"] = { "<cmd> Themery <CR>", "Change Themes" },
  },

  ["t"] = {
    ["<Esc>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "Escape terminal mode" },
  },

  ["v"] = {
    ["<"] = { "<gv", "Indent line" },
    [">"] = { ">gv", "Indent line" },
  },
  ["x"] = {
    ["<leader>/"] = {
      "gc",
      "Comments visual block",
      remap = true,
    },
  },
}

M.lsp = {
  ["n"] = {
    ["grn"] = { vim.lsp.buf.rename, "Rename variable" },
    ["gra"] = { vim.lsp.buf.code_action, "Code action" },
    ["grr"] = { vim.lsp.buf.references, "References" },
    ["grf"] = { vim.lsp.buf.format, "Format" },
    ["grk"] = { vim.lsp.buf.hover, "Hover" },
  },
}
M.telescope = {
  ["n"] = {
    ["<leader>ff"] = { builtin.find_files, "Telescope find files" },
    ["<leader>fw"] = { builtin.live_grep, "Telescope live grep" },
    ["<leader>fb"] = { builtin.buffers, "Telescope buffers" },
    ["<leader>fh"] = { builtin.help_tags, "Telescope help" },
    ["<leader>fn"] = { "<cmd> Telescope notify <CR>", "Telescope notify" },
  },
}
M.notsogeneral = {
  ["n"] = {
    ["<leader>gt"] = { "<cmd> Themery <CR>", "Change Themes" },
    ["<leader>gm"] = { "<cmd> Mason <CR>", "Open Mason UI" },
    ["<leader>gf"] = { ":TSInstall ", "Treesitter Install " },
    ["<leader>go"] = { "<cmd> Oil <CR>", "Oil" },
    ["<leader>gn"] = { "<cmd> set nu! <CR>", "Toggle line number" },
    ["<leader>gr"] = { "<cmd> set rnu! <CR>", "Toggle relative number" },
    ["<leader>gw"] = { start_resize_mode, "Activate resize mode" },
    ["<leader>gh"] = { "q:", "Command history" },
    ["<leader>gc"] = { "<cmd> RunCode <CR>", "Run code" },
    ["<leader>ge"] = { "<cmd> WindowsEqualize <CR>", "Make windows equal" },
    ["<leader>gd"] = { "gg0vG$d", "Clear Buffer" },
    ["<leader>gl"] = { "<cmd> Lazy<CR>", "Lazy" },
  },
}
M.terminal = {
  ["n"] = {
    ["<leader>th"] = { "<cmd> ToggleTerm direction=horizontal <CR>", "Terminal horizontal" },
    ["<leader>tv"] = { "<cmd> ToggleTerm direction=vertical <CR>", "Terminal vertical" },
    ["<leader>tt"] = { "<cmd> ToggleTerm direction=tab <CR>", "Terminal tab" },
    ["<leader>tf"] = { "<cmd> ToggleTerm direction=float <CR>", "Terminal float" },
    ["<leader>tl"] = { "<cmd> ToggleTermSendCurrentLine <CR>", "Send current line to Terminal" },
  },
  ["v"] = {
    ["<leader>ts"] = { "<cmd> ToggleTermSendVisualSelection <CR>", "Send visual selection to terminal" },
    ["<leader>tl"] = { "<cmd> ToggleTermSendVisualLines <CR>", "Send visual lines to terminal" },
  },
}
M.competitest = {
  ["n"] = {
    ["<leader>ca"] = { "<cmd> CompetiTest add_testcase<CR>", "Add Testcase" },
    ["<leader>ce"] = { "<cmd> CompetiTest edit_testcase<CR>", "Edit Testcase" },
    ["<leader>cr"] = { "<cmd> CompetiTest run<CR>", "Competitest run" },
    ["<leader>cd"] = { "<cmd> CompetiTest delete_testcase<CR>", "Delete Testcase" },
    ["<leader>cw"] = { "<cmd> CompetiTest receive testcases<CR>", "Receive Testcases" },
    ["<leader>cc"] = { "<cmd> CompetiTest receive contest<CR>", "Receive Contest" },
    ["<leader>cp"] = {
      ':execute "%delete _ | read /home/auxi/Documents/compprog/cpTemplates/stand.cpp"<CR>',
      "Paste standard template",
    },
  },
}

M.kulala = {
  ["n"] = {
    ["<leader>kr"] = {
      function()
        require("kulala").run()
      end,
      "Kulala send request",
    },
    ["<leader>ka"] = {
      function()
        require("kulala").run_all()
      end,
      "Kulala send all requests (http only)",
    },
    ["<leader>ks"] = {
      function()
        require("kulala").scratchpad()
      end,
      "Kulala open scratchpad",
    },
    ["<leader>ko"] = {
      function()
        require("kulala").toggle_view()
      end,
      "Kulala toggle response view",
    },
    ["<leader>kj"] = {
      function()
        require("kulala").jump_next()
      end,
      "Kulala jump to next request",
    },
    ["<leader>kk"] = {
      function()
        require("kulala").jump_prev()
      end,
      "Kulala jump to previous request",
    },
    ["<leader>kc"] = {
      function()
        require("kulala").close()
      end,
      "Kulala close output view",
    },
  },
}

return M
