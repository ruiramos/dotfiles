set tabstop=2 softtabstop=1 expandtab shiftwidth=2 smarttab
syntax on

:set smartcase
:set ignorecase

" hides buffers instead of closing them
:set hidden

" autoreads files editted outside vim
:set autoread

" NERDTree opens with Ctrl m
map <silent> <C-k>b :NERDTreeToggle<CR>
map <silent> <C-k>f :NERDTreeFind<CR>

" removes trailing whitespace
autocmd BufWritePre * %s/\s\+$//e

" :((((
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

let mapleader=" "

nnoremap <leader>el :ElmEvalLine<CR>
vnoremap <leader>es :<C-u>ElmEvalSelection<CR>
nnoremap <leader>em :ElmMakeCurrentFile<CR>

" uses ag for ctrlp and grep
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

" ctrlp - set mru as default
let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_mruf_relative = 1

execute pathogen#infect()

call plug#begin('~/.vim/plugged')

" cores bonitas
Plug 'junegunn/seoul256.vim'

" git stuff
Plug 'tpope/vim-fugitive'

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

" colorful bar at the bottom
Plug 'vim-airline/vim-airline'

" elixir
Plug 'elixir-lang/vim-elixir'

" managing buffers
Plug 'qpkorr/vim-bufkill'

" editor config
Plug 'editorconfig/editorconfig-vim'

" expand selection
Plug 'terryma/vim-expand-region'

Plug 'heavenshell/vim-jsdoc'

" typescript
Plug 'Quramy/tsuquyomi'
Plug 'leafgarland/typescript-vim'

Plug 'Shougo/vimproc.vim', {'do' : 'make'}

" elm
Plug 'ElmCast/elm-vim'

" tag bar
" Plug 'majutsushi/tagbar'

call plug#end()

let g:seoul256_background = 234
colo seoul256

" fancy font
let g:airline_powerline_fonts = 1

" sets eslint for linting of js files
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = 'eslint_d'

let g:syntastic_elixir_checkers = ['elixir']
let g:syntastic_enable_elixir_checker = 1

" syntastic stuff
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" completion
filetype plugin on
set omnifunc=syntaxcomplete#Complete

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height = 5

set number

" reason stuff
if executable('ocamlmerlin')
  " To set the log file and restart:
  let s:ocamlmerlin=substitute(system('which ocamlmerlin'),'ocamlmerlin\n$','','') . "../share/merlin/vim/"
  execute "set rtp+=".s:ocamlmerlin
  let g:syntastic_ocaml_checkers=['merlin']
endif
if executable('refmt')
  let s:reason=substitute(system('which refmt'),'refmt\n$','','') . "../share/reason/editorSupport/VimReason"
  execute "set rtp+=".s:reason
  let g:syntastic_reason_checkers=['merlin']
endif

" editor config
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" youcompleteme - closing preview window
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1

