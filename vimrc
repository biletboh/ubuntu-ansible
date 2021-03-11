" Check https://www.vimfromscratch.com/articles/vim-for-python/
" pip install flake8 pylint

set nocompatible              " required
filetype off		      " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Colors
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'

" Navigation
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'tmhedberg/SimpylFold'

" Autocompletes
Bundle 'Valloric/YouCompleteMe'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'
Plugin 'jiangmiao/auto-pairs'

" Python linting
Plugin 'nvie/vim-flake8'
Plugin 'dense-analysis/ale'
Plugin 'Vimjas/vim-python-pep8-indent'
Plugin 'psf/black'
" Plugin 'vim-syntastic/syntastic'

" Vuejs
Plugin 'posva/vim-vue'

" Other
Plugin 'kien/ctrlp.vim'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'mattn/emmet-vim'
Plugin 'pearofducks/ansible-vim'
Plugin 'tpope/vim-commentary'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Splits
set splitbelow
set splitright
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
nnoremap <space> za
let g:SimpylFold_docstring_preview=1

" UTF8 Support
set encoding=utf-8

" Highlighting
let python_highlight_all=1
syntax on

" Color Schemes
if has('gui_running')
  set background=dark
  colorscheme solarized
else
  colorscheme zenburn
endif
call togglebg#map("<F5>")

" File Browsing
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" Autocompletion
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_python_binary_path = 'python3'

" Configuration for a nic display of cyrillic 
set iminsert=0
set imsearch=0

" Encoding settings
set fileencoding=utf-8
set encoding=utf-8
set termencoding=utf-8

" Indentation
set tabstop=4
set softtabstop=4
set shiftwidth=4

autocmd Filetype vue setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype javascript setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype html setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype sass setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
" autocmd Filetype html setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
" autocmd Filetype sass setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype scss setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype html setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype sass setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype yml setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
autocmd Filetype json setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set list
set nopaste

" Linting
let g:ale_linters = {
      \   'javascript': ['eslint'],
      \    'python': ['flake8', 'pylint'],
      \}

" let g:ale_fixers = {
"       \    'python': ['black'],
"       \}
nmap <F10> :ALEFix<CR>
let g:ale_fix_on_save = 1
let g:ale_lint_on_save = 1
let g:ale_linters_explicit = 1

function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  return l:counts.total == 0 ? '✨ all good ✨' : printf(
        \   '😞 %dW %dE',
        \   all_non_errors,
        \   all_errors
        \)
endfunction

set statusline=
set statusline+=%m
set statusline+=\ %f
set statusline+=%=
set statusline+=\ %{LinterStatus()}

let g:black_linelength=79
autocmd BufWritePre *.py execute ':Black'
