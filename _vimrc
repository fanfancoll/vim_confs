" Configuration file for vim
set modelines=0		" CVE-2007-2438

" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible	" Use Vim defaults instead of 100% vi compatibility
set backspace=2		" more powerful backspacing

let skip_defaults_vim=1

" General settings
set nu!
set list
set tabstop=4
set shiftwidth=4
set listchars=tab:>·,trail:·
set nowrap
set updatetime=500

" Enable folding
set foldmethod=indent
set foldlevel=99

" Settings for hicursorwords
"let g
"let g:HiCursorWords_hiGroupRegexp = 'statement\|I'

" YCM settings
"python with virtualenv support
" py << EOF
" import os
" import sys
" if 'VIRTUAL_ENV' in os.environ:
"   project_base_dir = os.environ['VIRTUAL_ENV']
"   activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"   execfile(activate_this, dict(__file__=activate_this))
" EOF
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_confirm_extra_conf=0
let g:ycm_always_populate_location_list=1
let g:ycm_max_diagnostics_to_display=0

" syntax check
let python_highlight_all=1
syntax on

" vimtex
let g:vimtex_view_method = 'zathura'
"""""""""
"" functions

" Highlight word under cursor
let g:no_highlight_group_for_current_word=["Statement", "Comment", "Type", "PreProc"]
function s:HighlightWordUnderCursor()
    let l:syntaxgroup = synIDattr(synIDtrans(synID(line("."), stridx(getline("."), expand('<cword>')) + 1, 1)), "name")

    if (index(g:no_highlight_group_for_current_word, l:syntaxgroup) == -1)
        exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))
    else
        exe 'match IncSearch /\V\<\>/'
    endif
endfunction

" NERDTree git plugin
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "*",
    \ "Staged"    : "+",
    \ "Untracked" : "U",
    \ "Renamed"   : "R",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "X",
    \ "Dirty"     : "/",
    \ "Clean"     : "<",
    \ "Ignored"   : "I",
    \ "Unknown"   : "?"
    \ }
let g:NERDTreeWinSize=20

""""""""""
"" AUTOCMDS
" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup nobackup
" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup nobackup
autocmd CursorMoved *.* call s:HighlightWordUnderCursor()
" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() != 0 || exists("s:std_in") | wincmd l | endif
" autocmd BufWinEnter * NERDTreeToggle
" Tagbar
"autocmd BufEnter * TagbarToggle
" Syntastic
" autocmd VimEnter * SyntasticToggleMode
" colorscheme
autocmd VimEnter * colorscheme molokai
" for ROS, set syntax of launch file as xml
autocmd BufNewFile,BufRead *.launch set ft=xml
" Disable mouse for gvim
autocmd VimEnter * set mouse=""
""""""""""
" maps
let mapleader="\\"
" close tab
nnoremap <leader>c :tabc<CR>
" edit vimrc
nnoremap <F9> :sp ~/.vimrc<CR>
nnoremap <F6> :so ~/.vimrc<CR>
" up down left right
nnoremap <left> <c-w><c-h>
nnoremap <right> <c-w><c-l>
nnoremap <up> <c-w><c-k>
nnoremap <down> <c-w><c-j>
" resize window
nnoremap <s-left> <c-w><
nnoremap <s-right> <c-w>>
nnoremap <s-up> <c-w>+
nnoremap <s-down> <c-w>-
" move between tabs
nnoremap <silent> - :tabp<CR>
" set to wrap
nnoremap <leader>w :set wrap<CR>
" git gutter
nnoremap <silent> <leader>f :GitGutterFold<CR>
" fugitive
nnoremap <silent> <leader>gd :Gdiff<CR>
" fold
nnoremap <silent> <space> za
" YCM
nnoremap <silent> <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <silent> <leader>f :YcmCompleter FixIt<CR>
" Tagbar
nnoremap <leader>t :TagbarToggle<CR>
" MarkdownPreview
nnoremap <leader>mp :MarkdownPreview<CR>
" NERDTree
nnoremap <silent> <leader>n :NERDTreeToggle<CR>:NERDTreeMirror<CR>
" map :NERDTreeToggle :NERDTreeMirror
""""""""
" Commands
" command Tq execute "tabclose"

""""""""""
" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'flazz/vim-colorschemes'
Plugin 'majutsushi/tagbar'
Plugin 'vim-airline/vim-airline'
" Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'tmhedberg/SimpylFold'
Plugin 'jiangmiao/auto-pairs'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'lervag/vimtex'

call vundle#end()

call plug#begin('~/.vim/plugged')

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

call plug#end()
