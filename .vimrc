set tabstop=2 softtabstop=1 expandtab shiftwidth=2 smarttab
syntax on

set smartcase
set ignorecase

set termguicolors

" hides buffers instead of closing them
set hidden

" autoreads files editted outside vim
set autoread

" disables swapfiles
set noswapfile

" shows whitespace chars
set list 

set noshowmode

set mouse=a

" shift happens
cnoreabbrev W w

" NERDTree opens with Ctrl m
map <silent> <C-k>b :NERDTreeToggle<CR>
map <silent> <C-k>f :NERDTreeFind<CR>

" disables comment auto insertion
autocmd FileType * setlocal formatoptions-=cro

" removes trailing whitespace
" autocmd BufWritePre * %s/\s\+$//e

au BufRead,BufNewFile *.handlebars set filetype=html

" :((((
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

let mapleader=","

nnoremap <leader>el :ElmEvalLine<CR>
vnoremap <leader>es :<C-u>ElmEvalSelection<CR>
nnoremap <leader>em :ElmMakeCurrentFile<CR>

" open todos file
nnoremap <leader>ed :vsp ~/.scratch/todo.md<CR>
nnoremap <leader>es :vsp ~/.scratch/sprint.md<CR>

if executable('rg')
  let g:ctrlp_user_command = 'rg --files %s'
  let g:ctrlp_use_caching = 0
  let g:ctrlp_working_path_mode = 'ra'
  let g:ctrlp_switch_buffer = 'et'
  let g:ackprg = "rg\ --vimgrep\ --no-heading\ --smart-case"
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
  set grepformat+=%f:%l:%c:%m
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
nnoremap \ :Ack<SPACE>

" ctrlp - set mru as default
let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_mruf_relative = 1
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("h")': ['<c-i>', '<2-LeftMouse>'],
    \ 'AcceptSelection("v")': ['<c-s>', '<RightMouse>'],
    \ }

let g:ale_fixers = {
  \ 'javascript': ['prettier', 'eslint'], 
  \ 'typescript': ['prettier', 'eslint'],
  \ 'rust': ['rustfmt'],
  \ 'reason': ['refmt'],
  \ 'python': ['black']
  \ }
let g:ale_fix_on_save = 1
let g:ale_python_auto_pipenv = 1
highlight clear ALEWarningSign

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

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
Plug 'maxmellon/vim-jsx-pretty'

Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

" less
Plug 'groenewege/vim-less'

" linting
Plug 'w0rp/ale'

" andar pros lados
Plug 'christoomey/vim-tmux-navigator'

" emmet
Plug 'mattn/emmet-vim'

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

" editor config
Plug 'editorconfig/editorconfig-vim'

" expand selection
Plug 'terryma/vim-expand-region'

Plug 'Shougo/vimproc.vim', {'do' : 'make'}

" elm
Plug 'ElmCast/elm-vim'

" reason
Plug 'reasonml-editor/vim-reason-plus'

" solidity
Plug 'tomlion/vim-solidity'

" lsp, autocomplete
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'godlygeek/tabular'

" auto detect ident settings
Plug 'tpope/vim-sleuth'

Plug 'rust-lang/rust.vim'

Plug 'haya14busa/vim-asterisk'

Plug 'mileszs/ack.vim'

call plug#end()

let g:seoul256_background = 234
colo seoul256

" fancy font
let g:airline_powerline_fonts = 1

" edit / source vimrc
nnoremap gev :e $MYVIMRC<CR>
nnoremap gsv :so $MYVIMRC<CR>

let g:deoplete#enable_at_startup = 1

set statusline+=%#warningmsg#
set statusline+=%*

" completion
filetype plugin on

set number
hi cursorline ctermbg=none
hi cursorlinenr ctermfg=red

" editor config
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" Get running OS
let os = ""
if has("win32")
  let os="win"
else
  if has("unix")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
      let os="mac"
    else
      let os="unix"
    endif
  endif
endif

" uses the system clipboard
set clipboard=unnamed
if os == 'unix'
    set clipboard=unnamedplus
endif

let g:LanguageClient_serverCommands = {
  \ 'javascript': ['javascript-typescript-stdio'],
  \ 'typescript': ['javascript-typescript-stdio'],
  \ 'javascript.jsx': ['javascript-typescript-stdio'],
  \ 'python': ['pyls', '-v'],
  \ 'reason': ['/usr/local/bin/reason-language-server.exe'],
  \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
  \ }

let g:LanguageClient_loggingLevel = 'INFO'
let g:LanguageClient_loggingFile = '/tmp/LanguageClient.log'
let g:LanguageClient_serverStderr = '/tmp/LanguageServer.log'
let g:LanguageClient_diagnosticsEnable = 0

" run rust fmt on save
let g:rustfmt_autosave = 0

nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <leader>h :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

nmap =j :%!python -m json.tool<CR>

" no idea what this is about anymore
hi def link tsxTag Function
hi def link tsxComponentName Function
hi def link tsxTagName Identifier
hi def link tsxCloseString Identifier
hi def link tsxCloseTag Identifier
hi def link tsxCloseTagName Identifier
hi def link tsxAttrib Type
hi def link typescriptEndColons Noise

" vim-asterisk
map *   <Plug>(asterisk-*)
map #   <Plug>(asterisk-#)
map g*  <Plug>(asterisk-g*)
map g#  <Plug>(asterisk-g#)
map z*  <Plug>(asterisk-z*)
map gz* <Plug>(asterisk-gz*)
map z#  <Plug>(asterisk-z#)
map gz# <Plug>(asterisk-gz#)

