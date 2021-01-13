set number            
set autoindent         
set smartindent         
set autoread 
set cursorline 
set relativenumber 
set tabstop=2         
set shiftwidth=2     
set expandtab       
set splitright     
set clipboard=unnamed
set hls             
set nowrap
set noswapfile
set noerrorbells                 
set novisualbell                
set incsearch
set hlsearch
set mouse=a
set hidden

syntax enable

map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>
inoremap <silent> jj <ESC>

nnoremap <C-t> :tabnew<cr> 
nnoremap <C-L> :tabnext<cr>
nnoremap <C-J> :tabprevious<cr> 

" Disable arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

nmap <buffer> gd <plug>(lsp-definition)
nmap <buffer> <f2> <plug>(lsp-rename)
inoremap <buffer> . .<C-x><C-o>

if &compatible
  set nocompatible
endif
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  call dein#load_toml('~/.config/nvim/dein.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/dein_lazy.toml', {'lazy': 1})

  if dein#check_install(['vimproc.vim'])
    call dein#install(['vimproc.vim'])
  endif
  if dein#check_install()
    call dein#install()
  endif
  call dein#end()
  call dein#save_state()
endif

"----------------------------------------------
" Deoplete 
"----------------------------------------------
let g:deoplete#enable_at_startup = 1

"----------------------------------------------
" Colors
"----------------------------------------------
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198s
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

set termguicolors
set background=dark

" Material colorscheme settings
let g:material_theme_style = 'darker-community'

" Ayu colorscheme settings
let ayucolor = 'dark'

" One colorscheme settings
let g:one_allow_italics = 1

colorscheme ayu

" Toggle background with <leader>bg
map <leader>bg :let &background = (&background == "dark"? "light" : "dark")<cr>

"----------------------------------------------
" Language: Go
"----------------------------------------------
let g:go_fmt_command = "goimports"
let g:goimports = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_auto_type_info = 1
let g:go_auto_sameids = 1
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

au filetype go inoremap <buffer> . .<C-x><C-o>

"----------------------------------------------
" Language: Rust
"----------------------------------------------
let g:rustfmt_autosave = 1

"----------------------------------------------
" Language: ProtoBuf
"----------------------------------------------
autocmd FileType proto ClangFormatAutoEnable

filetype plugin indent on

