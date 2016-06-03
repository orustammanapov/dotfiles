" ----------------------------------------------------------------------------
"   Plug
" ----------------------------------------------------------------------------

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Colorschemes
Plug 'captbaritone/molokai'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'altercation/vim-colors-solarized'
Plug 'fxn/vim-monochrome'
Plug 'NLKNguyen/papercolor-theme'
Plug 'jnurmine/Zenburn'
Plug 'w0ng/vim-hybrid'
Plug 'jordwalke/flatlandia'
Plug 'baskerville/bubblegum'

" Syntax
Plug 'tpope/vim-git', { 'for': 'git' }
Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }
Plug 'xsbeats/vim-blade', { 'for': 'blade' }
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }

" Make tab handle all completions
Plug 'ervandew/supertab'

" Easy file navigation
Plug 'easymotion/vim-easymotion'

" Split and join lines of code intelligently
Plug 'AndrewRadev/splitjoin.vim'

" Completion
Plug 'mattn/emmet-vim', { 'for': ['html', 'php', 'css', 'xml'] }

" Make commenting easier
Plug 'tpope/vim-commentary'

" Change brackets and quotes
Plug 'tpope/vim-surround'

" Make vim-surround repeatable with .
Plug 'tpope/vim-repeat'

" Fuzzy file opener
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Syntastic: Code linting errors
Plug 'scrooloose/syntastic', { 'for': ['php', 'python', 'javascript', 'css'] }

" Argument object
Plug 'vim-scripts/argtextobj.vim'

" Fugitive: Git from within Vim
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Fancy statusline
Plug 'vim-airline/vim-airline'

" LaTeX editing
Plug 'LaTeX-Box-Team/LaTeX-Box', { 'for': 'tex' }

" General Autocompletion
function! DoRemote(arg)
    UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }

" Neovim terminal improvement
if has('nvim')	
  Plug 'kassio/neoterm'
  Plug 'neomake/neomake'
endif

" Indent object
Plug 'michaeljsmith/vim-indent-object'

" Make % match xml tags
Plug 'edsono/vim-matchit', { 'for': ['html', 'php', 'xml'] }

" Adjust 'shiftwidth' and 'expandtab' heuristically based on the current file
Plug 'tpope/vim-sleuth'

" CamelCase motions through words
Plug 'bkad/CamelCaseMotion'

" Python completion and tag navigation
Plug 'davidhalter/jedi-vim', { 'for': 'python' }

" Find the class/method based on cursor position
Plug 'vim-scripts/pythonhelper', { 'for': 'python' }

" 'Vastly improved Javascript indentation and syntax support in Vim'
Plug 'pangloss/vim-javascript'

" Other plugins require curl
if executable("curl")
  " Webapi: Dependency of Gist-vim
  Plug 'mattn/webapi-vim'
  
  " Gist: Post text to gist.github
  Plug 'mattn/gist-vim'
endif

call plug#end()



" ----------------------------------------------------------------------------
"   Plugin Settings
" ----------------------------------------------------------------------------

" Changes default leader mapping from <c-y> to ',' and uses emmet in all modes
let g:user_emmet_leader_key=','
let g:user_emmet_mode='a'

" Sets font to patched powerline font (which should be on the system) to populate symbols
let g:airline_powerline_fonts = 1

" Makes solarized use 256 colors
let g:solarized_termcolors=256



" ----------------------------------------------------------------------------
"   Editor
" ----------------------------------------------------------------------------

" Disables line wrapping
set nowrap

" Command to enable soft word wrapping
command! -nargs=* Wrap set wrap linebreak nolist showbreak=…

" Enables file specific auto indentation
set autoindent
filetype plugin indent on

" Shows line number ans sets gutter width
set number
set numberwidth=4

" Sets tab settings
set ts=2 sts=0 sw=2 noexpandtab

" Shows cursorline
set cursorline

" Shows statusline
set laststatus=2

" Enables syntax highlighting
if has('syntax')
  syntax on
endif

" Sets folding method to file specific syntax
set foldmethod=syntax

" Ensures that vim uses 256 colours 
set term=xterm-256color
set t_Co=256

" Makes incompatible with vi
set nocompatible

" Specifies characters to fill status lines and vertical separators
set fillchars+=stl:\ ,stlnc:\

" Sets fileformat to define line endings to CR(carriage return) and LF(linefeed - cursor down)
set fileformats+=dos

" Sets default encoding to utf-8
set encoding=utf-8

" Enables automatic pasting inside terminal vim
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

" Enables systems clipboard usage
let &clipboard = has('unnamedplus') ? 'unnamedplus' : 'unnamed'

" Makes backspace work like in a normal editor
set backspace=indent,eol,start

" Highlights search matches and sets key mapping <esc>+<enter> to remove it
set hlsearch
nnoremap <CR> :noh<CR>

" Shows file name as a title and sets rigth formatting
set title
set titlestring=\%-25.55F\ %a%r%m titlelen=70

" Enables mouse usage
set mouse=a	

" Disables backup file creation
set nobackup



" ----------------------------------------------------------------------------
"   Mappings
" ----------------------------------------------------------------------------

" Move Between Splits
map <C-H> <C-W>h<C-W>
map <C-J> <C-W>j<C-W>
map <C-K> <C-W>k<C-W>
map <C-L> <C-W>l<C-W>

" Maps camel case motion to w, b and e mappings
map <silent> w <Plug>CamelCaseMotion_w
map <silent> b <Plug>CamelCaseMotion_b
map <silent> e <Plug>CamelCaseMotion_e
map <silent> ge <Plug>CamelCaseMotion_ge
sunmap w
sunmap b
sunmap e
sunmap ge

" Maps iw, ib and ie motions
omap <silent> iw <Plug>CamelCaseMotion_iw
xmap <silent> iw <Plug>CamelCaseMotion_iw
omap <silent> ib <Plug>CamelCaseMotion_ib
xmap <silent> ib <Plug>CamelCaseMotion_ib
omap <silent> ie <Plug>CamelCaseMotion_ie
xmap <silent> ie <Plug>CamelCaseMotion_ie



" ----------------------------------------------------------------------------
"   Colorschemes
" ----------------------------------------------------------------------------

" Choses between dark or light solorscheme
set background=dark

" silent! colorscheme molokai 
" silent! colorscheme Tomorrow 
" silent! colorscheme solarized
silent! colorscheme monochrome 
" silent! colorscheme PaperColor
" silent! colorscheme zenburn
" silent! colorscheme hybrid
" silent! colorscheme flatlandia
" silent! colorscheme bubblegum-256-dark
" silent! colorscheme bubblegum-256-light

