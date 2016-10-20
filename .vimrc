set tabstop=2 softtabstop=1 expandtab shiftwidth=2 smarttab
syntax on

" hides buffers instead of closing them
:set hidden

" NERDTree opens with Ctrl m
map <C-m> :NERDTreeToggle<CR>

" removes trailing whitespace
autocmd BufWritePre * %s/\s\+$//e

" :((((
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

execute pathogen#infect()

nnoremap <leader>el :ElmEvalLine<CR>
vnoremap <leader>es :<C-u>ElmEvalSelection<CR>
nnoremap <leader>em :ElmMakeCurrentFile<CR>

call plug#begin('~/.vim/plugged')

" cores bonitas
Plug 'junegunn/seoul256.vim'

" nao sei bem
Plug 'tpope/vim-sensible'

" file finder
Plug 'ctrlpvim/ctrlp.vim'

" git diffs
Plug 'airblade/vim-gitgutter'

" javascript
Plug 'pangloss/vim-javascript'
Plug 'elzr/vim-json'

" less
Plug 'groenewege/vim-less'

" linting
Plug 'scrooloose/syntastic'

" andar pros lados
Plug 'christoomey/vim-tmux-navigator'

" code completion
Plug 'Valloric/YouCompleteMe'

" emmet
Plug 'mattn/emmet-vim'

" elixir
Plug 'elixir-lang/vim-elixir'

" multiple cursors!
Plug 'terryma/vim-multiple-cursors'

" vim pug/jade
Plug 'digitaltoad/vim-pug'

" jump between requires
Plug 'moll/vim-node'

" surround stuff in other stuff
Plug 'tpope/vim-surround'

" unimpaired -  ] [ mappings
Plug 'tpope/vim-unimpaired'

" tree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

call plug#end()

let g:seoul256_background = 234
colo seoul256

" sets eslint for linting of js files
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = 'eslint_d'

" syntastic stuff
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" completion
filetype plugin on
set omnifunc=syntaxcomplete#Complete

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height = 5

" ctrl p
" let g:ctrlp_max_files=0
" let g:ctrlp_max_depth=40
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard']

set number
