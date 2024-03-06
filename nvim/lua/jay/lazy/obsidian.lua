return {
  "epwalsh/obsidian.nvim",
  version = "*",  -- recommended, use latest release instead of latest commit
  -- lazy = true,
  -- ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault
  -- event = {
  --   "BufReadPre /home/jay/Documents/Notes/LectureNotes/**.md",
  --   "BufNewFile /home/jay/Documents/Notes/LectureNotes/**.md"
  -- },
  dependencies = {
    "nvim-lua/plenary.nvim",

  },
  opts = {

		-- Alternatively - and for backwards compatibility - you can set 'dir' to a single path instead of
		-- 'workspaces'. For example:
	    dir = "~/Documents/Notes/",

		-- Optional, if you keep notes in a specific subdirectory of your vault.
		notes_subdir = "LectureNotes",

		-- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
		completion = {
			-- Set to false to disable completion.
			nvim_cmp = true,
			-- Trigger completion at 2 chars.
			min_chars = 2,
		},

		-- Optional, configure key mappings. These are the defaults. If you don't want to set any keymappings this
		-- way then set 'mappings = {}'.
		mappings = {
			-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
			["gf"] = {
				action = function()
					return require("obsidian").util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true, buffer = true },
			},
			-- Toggle check-boxes.
			["<leader>ch"] = {
				action = function()
					return require("obsidian").util.toggle_checkbox()
				end,
				opts = { buffer = true },
			},
		},

		-- Where to put new notes. Valid options are
		--  * "current_dir" - put new notes in same directory as the current buffer.
		--  * "notes_subdir" - put new notes in the default notes subdirectory.
		new_notes_location = "notes_subdir",


		-- Either 'wiki' or 'markdown'.
		preferred_link_style = "wiki",

		-- Optional, customize the default name or prefix when pasting images via `:ObsidianPasteImg`.
		---@return string
		image_name_func = function()
			-- Prefix image names with timestamp.
			return string.format("%s-", os.time())
		end,

		-- Optional, boolean or a function that takes a filename and returns a boolean.
		-- `true` indicates that you don't want obsidian.nvim to manage frontmatter.
		disable_frontmatter = false,


		-- Optional, for templates (see below).
		templates = {
			subdir = "templates",
			date_format = "%Y-%m-%d",
			time_format = "%H:%M",
			-- A map for custom variables, the key should be the variable and the value a function
			substitutions = {},
		},

		picker = {
			-- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
			name = "telescope.nvim",
			-- Optional, configure key mappings for the picker. These are the defaults.
			-- Not all pickers support all mappings.
			mappings = {
				-- Create a new note from your query.
				new = "<C-x>",
				-- Insert a link to the selected note.
				insert_link = "<C-l>",
			},
		},

		-- Optional, sort search results by "path", "modified", "accessed", or "created".
		-- The recommend value is "modified" and `true` for `sort_reversed`, which means, for example,
		-- that `:ObsidianQuickSwitch` will show the notes sorted by latest modified time
		sort_by = "modified",
		sort_reversed = true,

		-- Optional, determines how certain commands open notes. The valid options are:
		-- 1. "current" (the default) - to always open in the current window
		-- 2. "vsplit" - to open in a vertical split if there's not already a vertical split
		-- 3. "hsplit" - to open in a horizontal split if there's not already a horizontal split
		open_notes_in = "current",

		-- Optional, define your own callbacks to further customize behavior.
		callbacks = {
			-- Runs at the end of `require("obsidian").setup()`.
			---@param client obsidian.Client
			post_setup = function(client) end,

			-- Runs anytime you enter the buffer for a note.
			---@param client obsidian.Client
			---@param note obsidian.Note
			enter_note = function(client, note) end,

			-- Runs right before writing the buffer for a note.
			---@param client obsidian.Client
			---@param note obsidian.Note
			pre_write_note = function(client, note) end,

			-- Runs anytime the workspace is set/changed.
			---@param client obsidian.Client
			---@param workspace obsidian.Workspace
			post_set_workspace = function(client, workspace) end,
		},

		-- Specify how to handle attachments.
		attachments = {
			-- The default folder to place images in via `:ObsidianPasteImg`.
			-- If this is a relative path it will be interpreted as relative to the vault root.
			-- You can always override this per image by passing a full path to the command instead of just a filename.
			img_folder = "Assets/img",  -- This is the default
			-- A function that determines the text to insert in the note when pasting an image.
			-- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
			-- This is the default implementation.
			---@param client obsidian.Client
			---@param path obsidian.Path the absolute path to the image file
			---@return string
			img_text_func = function(client, path)
				local link_path
				local vault_relative_path = client:vault_relative_path(path)
				if vault_relative_path ~= nil then
					-- Use relative path if the image is saved in the vault dir.
					link_path = vault_relative_path
				else
					-- Otherwise use the absolute path.
					link_path = tostring(path)
				end
				local display_name = vim.fs.basename(link_path)
				return string.format("![%s](%s)", display_name, link_path)
			end,
		},
  },
}

-- Keymaps


