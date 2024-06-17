local _M = {
   terminal = os.getenv('TERMINAL') or 'alacritty',
   editor   = os.getenv('EDITOR')   or 'nvim',
   fileapp = 'pcmanfm-qt',
}

_M.terminal_folder_cmd = _M.terminal .. ' -e ranger'
_M.editor_cmd = _M.terminal .. ' -e ' .. _M.editor
_M.manual_cmd = _M.terminal .. ' -e man awesome'

return _M
