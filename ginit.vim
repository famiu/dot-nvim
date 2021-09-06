""" NVim QT configuration
packadd neovim-gui-shim
GuiTabline 0
GuiPopupmenu 0
GuiScrollBar 1
GuiLinespace 0
Guifont! SauceCodePro Nerd Font Mono:h10

" Right Click Context Menu (Copy-Cut-Paste)
nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
vnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv


