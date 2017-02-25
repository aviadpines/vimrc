" vim-plug {{{1

" Vim-Plug automatic installation {{{
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" }}}

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'ddollar/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'
Plug 'easymotion/vim-easymotion'
Plug 'altercation/vim-colors-solarized'
Plug 'ervandew/supertab'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'chase/vim-ansible-yaml'
Plug 'bling/vim-airline'
Plug 'glench/vim-jinja2-syntax'
Plug 'tmhedberg/SimpylFold'
Plug 'tpope/vim-fugitive'
Plug 'powerline/powerline' "needed for fugitive
Plug 'mbbill/undotree'
Plug 'nathanaelkane/vim-indent-guides'

call plug#end()

" Plugin configurations {{{2

" NERDTREE keymaps {{{3
map <leader>r :NERDTreeFind<CR>
map <silent> <C-D> :NERDTreeToggle<CR>
" }}}

" airline properties {{{3
let g:airline#extensions#tabline#enabled = 1
set laststatus=2
"}}} 

" Undotree {{{3
nnoremap <F5> :UndotreeToggle<cr>
" }}}

" solcaraized theme {{{3
" we want to load the color scheme it immidiately
call plug#load('vim-colors-solarized')
set background=dark
let g:solarized_termcolors=256
colorscheme solarized
" }}}

" Indent guides {{{3
let g:indent_guides_auto_colors = 0
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
"hi IndentGuidesEven ctermbg=238
"hi IndentGuidesOdd ctermbg=236
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=238
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=236
" }}} 

" }}}

" }}}

" Tabs {{{
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set expandtab       " tabs are spaces
set shiftwidth=4
" }}}

" Search {{{
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
" turn off search highlight by pressing \<space>
nnoremap <leader><space> :nohlsearch<CR>
" }}}

" Other misc configurations {{{
" set number              " show line numbers (set nu and set nonu)
set showcmd             " shows the last command entered in the very bottom right of Vim
set cursorline          " highlight current line
filetype indent on      " load filetype-specific indent files, e.g. ~/.vim/indent/python.vim is loaded when opening a *.py file.
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw only when we need to.
set showmatch           " highlight matching [{()}]
" }}}

" Language specific settings {{{ 
augroup configgroup
        autocmd!
        autocmd VimEnter * highlight clear SignColumn
        autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md :call <SID>StripTrailingWhitespaces()
        autocmd FileType java setlocal noexpandtab
        autocmd FileType java setlocal list
        autocmd FileType java setlocal listchars=tab:+\ 
        autocmd FileType java setlocal formatprg=par\ -w80\ -T4
        autocmd FileType php setlocal expandtab
        autocmd FileType php setlocal list
        autocmd FileType php setlocal listchars=tab:+\ ,eol:-
        autocmd FileType php setlocal formatprg=par\ -w80\ -T4
        autocmd FileType ruby setlocal tabstop=2
        autocmd FileType ruby setlocal shiftwidth=2
        autocmd FileType ruby setlocal softtabstop=2
        autocmd FileType ruby setlocal commentstring=#\ %s
        autocmd FileType python setlocal commentstring=#\ %s
        autocmd FileType json setlocal foldmethod=syntax
        autocmd FileType json setlocal foldcolumn=3
        autocmd BufEnter *.cls setlocal filetype=java
        autocmd BufEnter *.zsh-theme setlocal filetype=zsh
        autocmd BufEnter Makefile setlocal noexpandtab
        autocmd BufEnter *.sh setlocal tabstop=2
        autocmd BufEnter *.sh setlocal shiftwidth=2
        autocmd BufEnter *.sh setlocal softtabstop=2

        " Boxes integration {{{
        autocmd BufEnter * nmap ,mc !!boxes -d pound-cmt<CR>
        autocmd BufEnter * vmap ,mc !boxes -d pound-cmt<CR>
        autocmd BufEnter * nmap ,xc !!boxes -d pound-cmt -r<CR>
        autocmd BufEnter * vmap ,xc !boxes -d pound-cmt -r<CR>
        autocmd BufEnter * nmap ,mt !!boxes -d shell -s 80 -p a1l2<CR>
        autocmd BufEnter * vmap ,mt !boxes -d shell -s 80 -p a1l2<CR>
        autocmd BufEnter * nmap ,xt !!boxes -d shell -s 80 -p a1l2 -r<CR>
        autocmd BufEnter * vmap ,xt !boxes -d shell -s 80 -p a1l2 -r<CR>
        autocmd BufEnter *.sh nmap ,mc !!boxes -d pound-cmt<CR>
        autocmd BufEnter *.sh vmap ,mc !boxes -d pound-cmt<CR>
        autocmd BufEnter *.sh nmap ,xc !!boxes -d pound-cmt -r<CR>
        autocmd BufEnter *.sh vmap ,xc !boxes -d pound-cmt -r<CR>
        autocmd BufEnter *.html nmap ,mc !!boxes -d html-cmt<CR>
        autocmd BufEnter *.html vmap ,mc !boxes -d html-cmt<CR>
        autocmd BufEnter *.html nmap ,xc !!boxes -d html-cmt -r<CR>
        autocmd BufEnter *.html vmap ,xc !boxes -d html-cmt -r<CR>
        autocmd BufEnter *.[chly],*.[pc]c nmap ,mc !!boxes -d c-cmt<CR>
        autocmd BufEnter *.[chly],*.[pc]c vmap ,mc !boxes -d c-cmt<CR>
        autocmd BufEnter *.[chly],*.[pc]c nmap ,xc !!boxes -d c-cmt -r<CR>
        autocmd BufEnter *.[chly],*.[pc]c vmap ,xc !boxes -d c-cmt -r<CR>
        autocmd BufEnter *.C,*.cpp,*.java nmap ,mc !!boxes -d java-cmt<CR>
        autocmd BufEnter *.C,*.cpp,*.java vmap ,mc !boxes -d java-cmt<CR>
        autocmd BufEnter *.C,*.cpp,*.java nmap ,xc !!boxes -d java-cmt -r<CR>
        autocmd BufEnter *.C,*.cpp,*.java vmap ,xc !boxes -d java-cmt -r<CR>
        autocmd BufEnter .vimrc*,.exrc nmap ,mc !!boxes -d vim-cmt<CR>
        autocmd BufEnter .vimrc*,.exrc vmap ,mc !boxes -d vim-cmt<CR>
        autocmd BufEnter .vimrc*,.exrc nmap ,xc !!boxes -d vim-cmt -r<CR>
        autocmd BufEnter .vimrc*,.exrc vmap ,xc !boxes -d vim-cmt -r<CR>
        " }}}
augroup END

" strips trailing whitespace at the end of files. this
" is called on buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
        " save last search & cursor position
        let _s=@/
        let l = line(".")
        let c = col(".")
        %s/\s\+$//e
        let @/=_s
        call cursor(l, c)
endfunction
" }}}

" Misc {{{
set foldmethod=marker
set nu
" Allow saving of files as sudo when I forgot to start vim using sudo by using w!!
cmap w!! w !sudo tee > /dev/null %

 " }}}

" To unfold, move cursor to the section and hit <SPACE>
