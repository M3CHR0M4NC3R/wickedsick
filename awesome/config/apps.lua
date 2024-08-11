local _M = {
   terminal = os.getenv('TERMINAL') or 'alacritty',
   editor   = os.getenv('EDITOR')   or 'nvim',
   fileapp = 'pcmanfm-qt',
   webbrowser = 'firefox',
   emailclient = 'thunderbird',
}

terminal_folder_cmd = _M.terminal .. ' -e ranger'
editor_cmd = _M.terminal .. ' -e ' .. _M.editor
manual_cmd = _M.terminal .. ' -e man awesome'

return _M
