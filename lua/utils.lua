local utils = {}

function utils.map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function utils.nmap(shortcut, command)
  utils.map('n', shortcut, command)
end

function utils.cmap(shortcut, command)
  utils.map('c', shortcut, command)
end

function utils.imap(shortcut, command)
  utils.map('i', shortcut, command)
end

return utils
