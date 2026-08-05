local cached_branch = ""
local last_check = 0
local function git_branch()
  local now = vim.uv.now()
  if now - last_check > 5000 then -- Check every 5 seconds
    cached_branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
    last_check = now
  end
  if cached_branch ~= "" then
    return " \u{e725} " .. cached_branch .. " " -- nf-dev-git_branch
  end
  return ""
end

-- File type with Nerd Font icon
local devicons = require("nvim-web-devicons")
local function file_type()
  local filename = vim.fn.expand("%:t")
  local extension = vim.fn.expand("%:e")

  local icon, _ = devicons.get_icon(filename, extension, {
    default = true,
  })

  local ft = vim.bo.filetype
  if ft == "" then
    ft = "text"
  end

  return string.format("%s %s", icon, ft)
end


-- Mode indicators with Nerd Font icons
local function mode_icon()
  local mode = vim.fn.mode()
  local modes = {
    n = " \u{f121}  NORMAL",
    i = " \u{f11c}  INSERT",
    v = " \u{f0168} VISUAL",
    V = " \u{f0168} V-LINE",
    ["\22"] = " \u{f0168} V-BLOCK",
    c = " \u{f120} COMMAND",
    s = " \u{f0c5} SELECT",
    S = " \u{f0c5} S-LINE",
    ["\19"] = " \u{f0c5} S-BLOCK",
    R = " \u{f044} REPLACE",
    r = " \u{f044} REPLACE",
    ["!"] = " \u{f489} SHELL",
    t = " \u{f120} TERMINAL",
  }
  return modes[mode] or (" \u{f059} " .. mode)
end

_G.mode_icon = mode_icon
_G.git_branch = git_branch
_G.file_type = file_type

vim.cmd([[
highlight StatusLineBold gui=bold cterm=bold
]])

-- Function to change statusline based on window focus
local function setup_dynamic_statusline()
  vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
    callback = function()
      vim.opt_local.statusline = table.concat({
	"%#StatusMode#", " %{v:lua.mode_icon()} ",
	"%#SepModeFile#",
	"%#StatusFile#", " %f %h%m%r ",
	"%#SepFileMid#", "",
	"%=",
	"%#SepMidType#", "",
	"%#StatusType#", " %{v:lua.file_type()} ",
	"%#SepTypePos#",
	"%#StatusPos#", " \u{f017} %l:%c %P ",
      })
    end,
  })
  vim.api.nvim_set_hl(0, "StatusLineBold", { bold = true })

  vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
    callback = function()
      vim.opt_local.statusline = "  %f %h%m%r \u{e0b1} %{v:lua.file_type()} %=  %l:%c   %P "
    end,
  })
end

setup_dynamic_statusline()
