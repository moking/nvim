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

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.vimwiki_custom_wiki2html='~/.vim/bundles/vimwiki/autoload/vimwiki/customwiki2html.sh'

require('lazy').setup("plugins")

-- Vim mappings, see lua/config/which.lua for more mappings
require("mappings")

-- All non plugin related (vim) options
require("options")

-- Vim autocommands/autogroups
require("autocmds")

-- Set favorite colorscheme
require("colorscheme")

local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        if opts.desc then
            opts.desc = "keymaps.lua: " .. opts.desc
        end
        options = vim.tbl_extend('force', options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

-- here some of my mappings:
-- jump to the last changed spot
--map("n", "<f12>", "<C-]>", { desc = "Jump to definition"})
map("n", "fb", "<C-t>", { desc = "Jump back from definition"})
map("n", "<C-x>2", "<esc>:split<cr>", { desc = ""})
map("n", "<C-x>3", "<esc>:vsplit<cr>", { desc = ""})
map("n", "rb", "o<enter>Reviewed-by: Fan Ni <fan.ni@samsung.com><enter><esc>", { desc = ""})
map("n", "tb", "o<enter>Tested-by: Fan Ni <fan.ni@samsung.com><enter><esc>", { desc = ""})
map("n", "qq", "<esc>:q<cr>", { desc = "quit window"})
map("n", "ww", "<C-w><C-w>", { desc = "switch buffer"})

map("n", "<f2>", "<esc>:w<cr>", { desc = "save buffer"})
map("i", "<f2>", "<esc>:w<cr>", { desc = "save buffer"})
map("n", "<f3>", "<esc>:set list!<cr>", { desc = ""})
map("n", "<f4>", "<esc>:set expandtab!<cr>", { desc = ""})
map("n", "<f5>", "<esc>:GitGutterQuickFix | copen <return>", { desc = ""})
map("n", "<f1>", "<esc>:Telescope oldfiles<cr>", { desc = ""})

map("n", "--", "^i\t- <esc>$", { desc = "generate itemize"})

vim.cmd("let g:vimwiki_list = [{'path': '~/vimwiki/src/', 'syntax': 'markdown', 'ext': '.md', 'path_html': '~/vimwiki/html/'}]")
vim.cmd("let g:vimwiki_custom_wiki2html='~/.vim/bundles/vimwiki/autoload/vimwiki/customwiki2html.sh'")

vim.cmd("set listchars=tab:\\|-,space:.")
vim.cmd("set listchars=tab:>·,trail:~,extends:>,precedes:<,space:␣")
vim.cmd("set cc=80")
vim.cmd("set textwidth=80")
-- vim.cmd("set fo+=a")
vim.cmd("set cino+=(0")

require('Comment').setup()
require('mini.align').setup()
local neogit = require("neogit")
neogit.setup {
  -- Hides the hints at the top of the status buffer
  disable_hint = false,
  -- Disables changing the buffer highlights based on where the cursor is.
  disable_context_highlighting = false,
  -- Disables signs for sections/items/hunks
  disable_signs = false,
  -- Offer to force push when branches diverge
  prompt_force_push = true,
  -- Changes what mode the Commit Editor starts in. `true` will leave nvim in normal mode, `false` will change nvim to
  -- insert mode, and `"auto"` will change nvim to insert mode IF the commit message is empty, otherwise leaving it in
  -- normal mode.
  disable_insert_on_commit = "auto",
  -- When enabled, will watch the `.git/` directory for changes and refresh the status buffer in response to filesystem
  -- events.
  filewatcher = {
    interval = 1000,
    enabled = true,
  },
  -- "ascii"   is the graph the git CLI generates
  -- "unicode" is the graph like https://github.com/rbong/vim-flog
  -- "kitty"   is the graph like https://github.com/isakbm/gitgraph.nvim - use https://github.com/rbong/flog-symbols if you don't use Kitty
  graph_style = "ascii",
  -- Show relative date by default. When set, use `strftime` to display dates
  commit_date_format = nil,
  log_date_format = nil,
  -- Show message with spinning animation when a git command is running.
  process_spinner = false,
  -- Used to generate URL's for branch popup action "pull request".
  git_services = {
    ["github.com"] = "https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1",
    ["bitbucket.org"] = "https://bitbucket.org/${owner}/${repository}/pull-requests/new?source=${branch_name}&t=1",
    ["gitlab.com"] = "https://gitlab.com/${owner}/${repository}/merge_requests/new?merge_request[source_branch]=${branch_name}",
    ["azure.com"] = "https://dev.azure.com/${owner}/_git/${repository}/pullrequestcreate?sourceRef=${branch_name}&targetRef=${target}",
  },
  -- Allows a different telescope sorter. Defaults to 'fuzzy_with_index_bias'. The example below will use the native fzf
  -- sorter instead. By default, this function returns `nil`.
  telescope_sorter = function()
    return require("telescope").extensions.fzf.native_fzf_sorter()
  end,
  -- Persist the values of switches/options within and across sessions
  remember_settings = true,
  -- Scope persisted settings on a per-project basis
  use_per_project_settings = true,
  -- Table of settings to never persist. Uses format "Filetype--cli-value"
  ignored_settings = {
    "NeogitPushPopup--force-with-lease",
    "NeogitPushPopup--force",
    "NeogitPullPopup--rebase",
    "NeogitCommitPopup--allow-empty",
    "NeogitRevertPopup--no-edit",
  },
  -- Configure highlight group features
  highlight = {
    italic = true,
    bold = true,
    underline = true
  },
  -- Set to false if you want to be responsible for creating _ALL_ keymappings
  use_default_keymaps = true,
  -- Neogit refreshes its internal state after specific events, which can be expensive depending on the repository size.
  -- Disabling `auto_refresh` will make it so you have to manually refresh the status after you open it.
  auto_refresh = true,
  -- Value used for `--sort` option for `git branch` command
  -- By default, branches will be sorted by commit date descending
  -- Flag description: https://git-scm.com/docs/git-branch#Documentation/git-branch.txt---sortltkeygt
  -- Sorting keys: https://git-scm.com/docs/git-for-each-ref#_options
  sort_branches = "-committerdate",
  -- Default for new branch name prompts
  initial_branch_name = "",
  -- Change the default way of opening neogit
  kind = "tab",
  -- Disable line numbers
  disable_line_numbers = true,
  -- Disable relative line numbers
  disable_relative_line_numbers = true,
  -- The time after which an output console is shown for slow running commands
  console_timeout = 2000,
  -- Automatically show console if a command takes more than console_timeout milliseconds
  auto_show_console = true,
  -- Automatically close the console if the process exits with a 0 (success) status
  auto_close_console = true,
  notification_icon = "󰊢",
  status = {
    show_head_commit_hash = true,
    recent_commit_count = 10,
    HEAD_padding = 10,
    HEAD_folded = false,
    mode_padding = 3,
    mode_text = {
      M = "modified",
      N = "new file",
      A = "added",
      D = "deleted",
      C = "copied",
      U = "updated",
      R = "renamed",
      DD = "unmerged",
      AU = "unmerged",
      UD = "unmerged",
      UA = "unmerged",
      DU = "unmerged",
      AA = "unmerged",
      UU = "unmerged",
      ["?"] = "",
    },
  },
  commit_editor = {
    kind = "tab",
    show_staged_diff = true,
    -- Accepted values:
    -- "split" to show the staged diff below the commit editor
    -- "vsplit" to show it to the right
    -- "split_above" Like :top split
    -- "vsplit_left" like :vsplit, but open to the left
    -- "auto" "vsplit" if window would have 80 cols, otherwise "split"
    staged_diff_split_kind = "split",
    spell_check = true,
  },
  commit_select_view = {
    kind = "tab",
  },
  commit_view = {
    kind = "vsplit",
    verify_commit = vim.fn.executable("gpg") == 1, -- Can be set to true or false, otherwise we try to find the binary
  },
  log_view = {
    kind = "tab",
  },
  rebase_editor = {
    kind = "auto",
  },
  reflog_view = {
    kind = "tab",
  },
  merge_editor = {
    kind = "auto",
  },
  description_editor = {
    kind = "auto",
  },
  tag_editor = {
    kind = "auto",
  },
  preview_buffer = {
    kind = "floating_console",
  },
  popup = {
    kind = "split",
  },
  stash = {
    kind = "tab",
  },
  refs_view = {
    kind = "tab",
  },
  signs = {
    -- { CLOSED, OPENED }
    hunk = { "", "" },
    item = { ">", "v" },
    section = { ">", "v" },
  },
  -- Each Integration is auto-detected through plugin presence, however, it can be disabled by setting to `false`
  integrations = {
    -- If enabled, use telescope for menu selection rather than vim.ui.select.
    -- Allows multi-select and some things that vim.ui.select doesn't.
    telescope = nil,
    -- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `diffview`.
    -- The diffview integration enables the diff popup.
    --
    -- Requires you to have `sindrets/diffview.nvim` installed.
    diffview = nil,

    -- If enabled, uses fzf-lua for menu selection. If the telescope integration
    -- is also selected then telescope is used instead
    -- Requires you to have `ibhagwan/fzf-lua` installed.
    fzf_lua = nil,

    -- If enabled, uses mini.pick for menu selection. If the telescope integration
    -- is also selected then telescope is used instead
    -- Requires you to have `echasnovski/mini.pick` installed.
    mini_pick = nil,
  },
  sections = {
    -- Reverting/Cherry Picking
    sequencer = {
      folded = false,
      hidden = false,
    },
    untracked = {
      folded = false,
      hidden = false,
    },
    unstaged = {
      folded = false,
      hidden = false,
    },
    staged = {
      folded = false,
      hidden = false,
    },
    stashes = {
      folded = true,
      hidden = false,
    },
    unpulled_upstream = {
      folded = true,
      hidden = false,
    },
    unmerged_upstream = {
      folded = false,
      hidden = false,
    },
    unpulled_pushRemote = {
      folded = true,
      hidden = false,
    },
    unmerged_pushRemote = {
      folded = false,
      hidden = false,
    },
    recent = {
      folded = true,
      hidden = false,
    },
    rebase = {
      folded = true,
      hidden = false,
    },
  },
  mappings = {
    commit_editor = {
      ["q"] = "Close",
      ["<c-c><c-c>"] = "Submit",
      ["<c-c><c-k>"] = "Abort",
      ["<m-p>"] = "PrevMessage",
      ["<m-n>"] = "NextMessage",
      ["<m-r>"] = "ResetMessage",
    },
    commit_editor_I = {
      ["<c-c><c-c>"] = "Submit",
      ["<c-c><c-k>"] = "Abort",
    },
    rebase_editor = {
      ["p"] = "Pick",
      ["r"] = "Reword",
      ["e"] = "Edit",
      ["s"] = "Squash",
      ["f"] = "Fixup",
      ["x"] = "Execute",
      ["d"] = "Drop",
      ["b"] = "Break",
      ["q"] = "Close",
      ["<cr>"] = "OpenCommit",
      ["gk"] = "MoveUp",
      ["gj"] = "MoveDown",
      ["<c-c><c-c>"] = "Submit",
      ["<c-c><c-k>"] = "Abort",
      ["[c"] = "OpenOrScrollUp",
      ["]c"] = "OpenOrScrollDown",
    },
    rebase_editor_I = {
      ["<c-c><c-c>"] = "Submit",
      ["<c-c><c-k>"] = "Abort",
    },
    finder = {
      ["<cr>"] = "Select",
      ["<c-c>"] = "Close",
      ["<esc>"] = "Close",
      ["<c-n>"] = "Next",
      ["<c-p>"] = "Previous",
      ["<down>"] = "Next",
      ["<up>"] = "Previous",
      ["<tab>"] = "InsertCompletion",
      ["<space>"] = "MultiselectToggleNext",
      ["<s-space>"] = "MultiselectTogglePrevious",
      ["<c-j>"] = "NOP",
      ["<ScrollWheelDown>"] = "ScrollWheelDown",
      ["<ScrollWheelUp>"] = "ScrollWheelUp",
      ["<ScrollWheelLeft>"] = "NOP",
      ["<ScrollWheelRight>"] = "NOP",
      ["<LeftMouse>"] = "MouseClick",
      ["<2-LeftMouse>"] = "NOP",
    },
    -- Setting any of these to `false` will disable the mapping.
    popup = {
      ["?"] = "HelpPopup",
      ["A"] = "CherryPickPopup",
      ["d"] = "DiffPopup",
      ["M"] = "RemotePopup",
      ["P"] = "PushPopup",
      ["X"] = "ResetPopup",
      ["Z"] = "StashPopup",
      ["i"] = "IgnorePopup",
      ["t"] = "TagPopup",
      ["b"] = "BranchPopup",
      ["B"] = "BisectPopup",
      ["w"] = "WorktreePopup",
      ["c"] = "CommitPopup",
      ["f"] = "FetchPopup",
      ["l"] = "LogPopup",
      ["m"] = "MergePopup",
      ["p"] = "PullPopup",
      ["r"] = "RebasePopup",
      ["v"] = "RevertPopup",
    },
    status = {
      ["j"] = "MoveDown",
      ["k"] = "MoveUp",
      ["o"] = "OpenTree",
      ["q"] = "Close",
      ["I"] = "InitRepo",
      ["1"] = "Depth1",
      ["2"] = "Depth2",
      ["3"] = "Depth3",
      ["4"] = "Depth4",
      ["Q"] = "Command",
      ["<tab>"] = "Toggle",
      ["x"] = "Discard",
      ["s"] = "Stage",
      ["S"] = "StageUnstaged",
      ["<c-s>"] = "StageAll",
      ["u"] = "Unstage",
      ["K"] = "Untrack",
      ["U"] = "UnstageStaged",
      ["y"] = "ShowRefs",
      ["$"] = "CommandHistory",
      ["Y"] = "YankSelected",
      ["<c-r>"] = "RefreshBuffer",
      ["<cr>"] = "GoToFile",
      ["<s-cr>"] = "PeekFile",
      ["<c-v>"] = "VSplitOpen",
      ["<c-x>"] = "SplitOpen",
      ["<c-t>"] = "TabOpen",
      ["{"] = "GoToPreviousHunkHeader",
      ["}"] = "GoToNextHunkHeader",
      ["[c"] = "OpenOrScrollUp",
      ["]c"] = "OpenOrScrollDown",
      ["<c-k>"] = "PeekUp",
      ["<c-j>"] = "PeekDown",
      ["<c-n>"] = "NextSection",
      ["<c-p>"] = "PreviousSection",
    },
  },
}

local wilder = require('wilder')
wilder.setup({modes = {':', '/', '?'}})
wilder.set_option('pipeline', {
  wilder.branch(
    wilder.cmdline_pipeline({
      -- 'python' needs the pynvim provider, which is not installed
      language = 'vim',
      -- 0 turns off fuzzy matching
      -- 1 turns on fuzzy matching
      -- 2 partial fuzzy matching (match does not have to begin with the same first letter)
      fuzzy = 1,
    }),
    wilder.vim_search_pipeline()
  ),
})

vim.g.SuperTabContextDefaultCompletionType = "<c-n>"

require('lspconfig').harper_ls.setup{}
-- require('lspconfig').python_lsp_server.setup{}

require('modes').setup({
	colors = {
		bg = "", -- Optional bg param, defaults to Normal hl group
		copy = "#f5c359",
		delete = "#c75c6a",
		insert = "#78ccc5",
		visual = "#9745be",
	},

	-- Set opacity for cursorline and number background
	line_opacity = 0.15,

	-- Enable cursor highlights
	set_cursor = true,

	-- Enable cursorline initially, and disable cursorline for inactive windows
	-- or ignored filetypes
	set_cursorline = true,

	-- Enable line number highlights to match cursorline
	set_number = true,

	-- Enable sign column highlights to match cursorline
	set_signcolumn = true,

	-- Disable modes highlights in specified filetypes
	-- Please PR commonly ignored filetypes
	ignore_filetypes = { 'NvimTree', 'TelescopePrompt' }
})

require("fzf-lua").setup({
  "hide",
  -- your other settings here 
})

require('gitsigns').setup {
  signs = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signs_staged = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signs_staged_enable = true,
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true
  },
  auto_attach = true,
  attach_to_untracked = false,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 100,
    use_focus = true,
  },
  current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
}

vim.keymap.set('n', '<leader>gl', function()
  local line = vim.fn.line('.')
  local file = vim.fn.expand('%:p') -- Full path to current file

  -- Run git blame on the current line
  local output = vim.fn.systemlist(
    'git blame -c -L ' .. line .. ',' .. line .. ' -- ' .. vim.fn.shellescape(file)
  )

  if vim.v.shell_error ~= 0 or #output == 0 then
    vim.notify('git blame failed or returned nothing', vim.log.levels.ERROR)
    return
  end

  -- Extract SHA from the first part of the line
  local sha = string.match(output[1], '^[^%s]+')
  if not sha or sha == '00000000' then
    vim.notify('No valid commit found on this line', vim.log.levels.INFO)
    return
  end

  -- Open Floaterm with git show
  vim.api.nvim_command('FloatermNew --autoclose=0 git show ' .. sha)
end, { desc = 'Git show for current line blame commit (Floaterm)' })

vim.keymap.set('n', '<M-x>', '<esc>:FloatermNew --autoclose=0 --width=0.8 --height=0.7 ', { noremap = true, silent = false })
vim.keymap.set("n", "<leader>y", "yiw", { noremap = true })
vim.keymap.set("n", "<leader>xb", "<esc>:FloatermNew --autoclose=0 --width=0.95 --height=0.9 w3m -B<cr>", { noremap = true })


vim.keymap.set("n", "<leader>cf", "<esc>:lua vim.lsp.buf.incoming_calls()<cr>", { noremap = true })
vim.keymap.set("n", "<leader>ct", "<esc>:lua vim.lsp.buf.outgoing_calls()<cr>", { noremap = true })

local cursor_sessions = {}
local cursor_last = 1

local function cursor_session(n)
  if not cursor_sessions[n] then
    cursor_sessions[n] = require("toggleterm.terminal").Terminal:new({
      -- offset so <count><C-n> toggleterm ids never pick up an agent session
      id = 100 + n,
      cmd = "agent",
      display_name = "Cursor " .. n,
      direction = "float",
      hidden = true,
      float_opts = {
        width = function() return math.floor(vim.o.columns * 0.9) end,
        height = function() return math.floor(vim.o.lines * 0.9) end,
      },
      on_exit = function() cursor_sessions[n] = nil end,
    })
  end
  return cursor_sessions[n]
end

local function cursor_open_session()
  for i, term in pairs(cursor_sessions) do
    if term:is_open() then return i end
  end
end

local function cursor_show(n)
  local open = cursor_open_session()
  if open and open ~= n then cursor_sessions[open]:close() end
  cursor_last = n
  if open ~= n then cursor_session(n):open() end
end

-- <count> picks a session; no count hides the open one or reopens the last used
local function toggle_cursor_agent()
  local n = vim.v.count
  local open = cursor_open_session()
  if open and (n == 0 or n == open) then
    cursor_sessions[open]:close()
    return
  end
  cursor_show(n == 0 and cursor_last or n)
end

local function pick_cursor_agent()
  local open = cursor_open_session()
  if open then cursor_sessions[open]:close() end

  local items = vim.tbl_keys(cursor_sessions)
  table.sort(items)
  local new = 1
  while cursor_sessions[new] do new = new + 1 end
  table.insert(items, "new")

  vim.ui.select(items, {
    prompt = "Cursor sessions",
    format_item = function(n)
      if n == "new" then return "+ New session (Cursor " .. new .. ")" end
      return "Cursor " .. n .. (n == cursor_last and "  (last)" or "")
    end,
  }, function(choice)
    if choice then cursor_show(choice == "new" and new or choice) end
  end)
end

vim.keymap.set("n", "<leader>ca", toggle_cursor_agent, { desc = "Toggle Cursor agent ([count] = session)" })
vim.keymap.set({ "n", "t" }, "<M-a>", toggle_cursor_agent, { desc = "Toggle Cursor agent ([count] = session)" })
vim.keymap.set("n", "<leader>cs", pick_cursor_agent, { desc = "Pick Cursor agent session" })
vim.keymap.set({ "n", "t" }, "<M-s>", pick_cursor_agent, { desc = "Pick Cursor agent session" })

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "TermLeave" }, {
  command = "silent! checktime",
})

require('litee.lib').setup({
    tree = {
        icon_set = "codicons"
    },
    panel = {
        orientation = "left",
        panel_size  = 30
    }
})
require('litee.calltree').setup({})
require('dict').setup()
vim.keymap.set('n', '<Leader>d', '<Cmd>lua require("dict").lookup()<CR>')
