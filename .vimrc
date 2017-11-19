call plug#begin('~/.vim/plugged')
Plug 'altercation/vim-colors-solarized'
Plug 'ntpeters/vim-better-whitespace'
Plug 'kien/rainbow_parentheses.vim'
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-fugitive'
"Plug 'gregsexton/gitv'
Plug 'airblade/vim-gitgutter', { 'on' : 'GitGutterToggle' }
Plug 'scrooloose/nerdtree', { 'on' : 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on' : 'NERDTreeToggle' }
Plug 'Valloric/YouCompleteMe', { 'for': 'python', 'do': './install.py' }
Plug 'vim-syntastic/syntastic', { 'for': 'python' }
"Plug 'jmcantrell/vim-virtualenv', { 'for': ['python', 'kv'] }
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }
Plug 'hdima/python-syntax', { 'for': 'python' }
Plug 'farfanoide/vim-kivy', { 'for': 'kv' }
call plug#end()

filetype plugin indent on
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set mouse=a
set number
set numberwidth=3
set foldmethod=indent
set foldlevel=99
set encoding=utf8
set updatetime=250

" Cursor
let &t_SI = "\<Esc>[5 q"
let &t_SR = "\<Esc>[3 q"
let &t_EI = "\<Esc>[1 q"
autocmd TermResponse * silent !echo -ne "\e[1 q"
autocmd ShellCmdPost * silent !echo -ne "\e[1 q"

" Key Mapping
map <F2> :NERDTreeToggle<CR>
map <F3> :GitGutterToggle<CR>
map <F4> :StripWhitespace<CR>
map <F5> :OverLengthToggle<CR>
map <F6> :RainbowParenthesesToggle<CR>
map <F7> :YcmAutoToggle<CR>
map <F8> :SyntasticCheck<CR>
map <Leader><F8> :SyntasticToggle<CR>
map <F9> :w\|!clear && python %
map <Leader><F9> :wa\|!clear && python %
map <F10> :w\|!clear && python main.py
map <Leader><F10> :wa\|!clear && python main.py

" Colorscheme
colorscheme solarized
let g:solarized_termtrans=1
autocmd ColorScheme * highlight LineNr ctermbg=none
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red
autocmd ColorScheme * highlight Pmenu term=none cterm=none
autocmd ColorScheme * highlight PmenuSbar term=none cterm=none
autocmd ColorScheme * highlight PmenuThumb term=none cterm=none
autocmd ColorScheme * highlight StatusLine term=none cterm=none
autocmd ColorScheme * highlight StatusLineNC term=none cterm=none
autocmd ColorScheme * highlight VertSplit ctermfg=0 ctermbg=0

" Syntax
syntax enable
let python_highlight_all=1

" Filetypes
au BufRead,BufNewFile *.kv set filetype=kv

" Rainbow Parentheses
autocmd Syntax * RainbowParenthesesLoadRound
autocmd Syntax * RainbowParenthesesLoadSquare
autocmd Syntax * RainbowParenthesesLoadBraces

" GitGutter
let g:gitgutter_enabled=0

" YouCompleteMe
let g:ycm_python_binary_path = 'python'
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_auto_trigger=0
function! YcmAutoToggle()
    if g:ycm_auto_trigger
        let g:ycm_auto_trigger=0
    else
        let g:ycm_auto_trigger=1
    endif
endfunction
command YcmAutoToggle call YcmAutoToggle()

" Syntastic
au BufRead,BufNewFile *.py setlocal statusline=%<%f\ %h%m%r
au BufRead,BufNewFile *.py setlocal statusline+=%#warningmsg#
au BufRead,BufNewFile *.py setlocal statusline+=%{SyntasticStatuslineFlag()}
au BufRead,BufNewFile *.py setlocal statusline+=%*
au BufRead,BufNewFile *.py setlocal statusline+=%=%-14.(%l,%c%V%)\ %P
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_aggregate_errors=1
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_wq=0
let g:syntastic_mode_map = { 'mode': 'passive' }

" Long Line Highlight
function! OverLengthToggle()
    if exists('w:long_line_match')
        silent! call matchdelete(w:long_line_match)
        unlet w:long_line_match
    elseif &textwidth > 0
        let w:long_line_match = matchadd('ErrorMsg', '\%>'.&tw.'v.\+', -1)
    else
        let w:long_line_match = matchadd('ErrorMsg', '\%>79v.\+', -1)
    endif
endfunction
command OverLengthToggle call OverLengthToggle()
