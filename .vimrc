set tabstop=2 softtabstop=1 expandtab shiftwidth=2 smarttab
syntax on

call plug#begin('~/.vim/plugged')

" cores bonitas 
Plug 'junegunn/seoul256.vim'

" nao sei bem
Plug 'tpope/vim-sensible'

" file finder
Plug 'kien/ctrlp.vim'

" git diffs
Plug 'airblade/vim-gitgutter'

" javascript
Plug 'pangloss/vim-javascript'
Plug 'elzr/vim-json'

" linting
Plug 'scrooloose/syntastic'

" andar pros lados
Plug 'christoomey/vim-tmux-navigator'

" code completion
Plug 'Valloric/YouCompleteMe'

" emmet
Plug 'mattn/emmet-vim'

call plug#end()

let g:seoul256_background = 234
colo seoul256

set number
