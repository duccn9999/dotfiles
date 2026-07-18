local M = {}



local SEP = ""
local NO_NAME = "[UNDEFINED]"



function M.set_highlights()
  vim.api.nvim_set_hl(0, "MyBufInactive", { fg = "#5D5C63", bg = "#141414" })

  vim.api.nvim_set_hl(0, "MyBufActive", { fg = "#141414", bg = "#5D5C63", bold = true })

  vim.api.nvim_set_hl(0, "MyBufSeparator", { fg = "#3A964E", bg = "#141414" })

  vim.api.nvim_set_hl(0, "MyBufClose", { fg = "#BF616A", bg = "#5D5C63" })
end

local function get_icon(filename, name)
  local ok, devicons = pcall(require, "nvim-web-devicons")

  if not ok or not name or name == "" then
    return ""
  end

  local ext = vim.fn.fnamemodify(name, ":e")

  local icon = devicons.get_icon(filename, ext, { default = true })

  return icon and (icon .. " ") or ""
end



local function get_display_name(path)
  if path == "" then
    return NO_NAME
  end

  local parts = vim.split(path, "/", { plain = true })

  if #parts == 1 then
    return parts[1]
  else
    return parts[#parts - 1] .. "/" .. parts[#parts]
  end
end



local function render_buf(bufnr, current)
  if not vim.api.nvim_buf_is_loaded(bufnr) then
    return ""
  end

  if not vim.bo[bufnr].buflisted then
    return ""
  end

  local name = vim.api.nvim_buf_get_name(bufnr)
  local display_name = get_display_name(name)
  local filename = (name ~= "" and vim.fn.fnamemodify(name, ":t")) or NO_NAME
  local icon = get_icon(filename, name)

  local modified = vim.bo[bufnr].modified
  local modified_icon = modified and " ●" or ""
  local content = icon .. display_name .. modified_icon
  if bufnr == current then
    return table.concat({

      "%#MyBufActive# ",

      content,

      " %#MyBufClose#",


      " %#MyBufSeparator#",

      SEP,

    })
  else
    return table.concat({

      "%#MyBufInactive# ",

      content,

      "  %#MyBufSeparator#",

      SEP,

    })
  end
end



function M.tabline()
  local current = vim.api.nvim_get_current_buf()
  local parts = {}

  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    local chunk = render_buf(bufnr, current)

    if chunk ~= "" then
      table.insert(parts, chunk)
    end
  end

  if #parts == 0 then
    return ""
  end

  return table.concat(parts):gsub(vim.pesc(SEP) .. "$", "")
end

function _G.tabline()
  local current = vim.api.nvim_get_current_buf()
  local parts = {}

  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    local chunk = render_buf(bufnr, current)

    if chunk ~= "" then
      table.insert(parts, chunk)
    end
  end

  if #parts == 0 then
    return ""
  end

  local line = table.concat(parts)

  return line:gsub(vim.pesc(SEP) .. "$", "")
end

function M.setup()
  M.set_highlights()

  vim.api.nvim_create_augroup("MyTabline", { clear = true })
  vim.api.nvim_create_autocmd("ColorScheme", {
    group = "MyTabline",
    callback = M.set_highlights,
  })
  vim.opt.showtabline = 2
  vim.opt.tabline = "%!v:lua.tabline()"
end

M.setup()
