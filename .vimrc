set nocompatible  " must be first line
set lazyredraw    " adds some needed speed in iTerm2
set noautochdir   " don't change dir when you open new files

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

set spell spelllang=en_us
filetype plugin indent on   " Automatically detect file types.
syntax on                   " syntax highlighting
set encoding=utf-8
scriptencoding utf-8

let g:spec_runner_dispatcher = 'call VtrSendCommand("be {command}")'
map <leader>t <plug>RunCurrentSpecFile
map <leader>s <plug>RunFocusedSpec
map <leader>l <plug>RunMostRecentSpec

" VtrRunner
nmap <leader>p :VtrKillRunner<CR>
nmap <leader>o :VtrOpenRunner({'percentage': 20})<CR>

" airline
set laststatus=2

" ack
let g:ackprg = 'ag --nogroup --nocolor --column'

" ctrlp ignore
let g:ctrlp_custom_ignore = "node_modules\|DS_Store\|git"

" clear before running specs
let g:VtrClearSequence = "clear\r"

" Make splits a bit more managable.
nnoremap <leader>1 :vs<CR><C-w>l
nnoremap <leader>2 :split<CR><C-w>j
nnoremap <C-Up> :bn<CR>
nnoremap <C-Down> :bp<CR>
nmap <silent> <A-k> :wincmd k<CR>
nmap <silent> <A-j> :wincmd j<CR>
nmap <silent> <A-h> :wincmd h<CR>
nmap <silent> <A-l> :wincmd l<CR>

vmap <Left> <gv
vmap <Right> >gv

" Easier moving in tabs and windows
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-L> <C-W>l<C-W>_
map <C-H> <C-W>h<C-W>_

" Map saves
nmap <C-S> :w<CR>
imap <C-S> <Esc>:w<CR>a

" General
set spell spelllang=en_us
filetype plugin indent on   " Automatically detect file types.
syntax on                   " syntax highlighting
set mouse=a                 " automatically enable mouse usage
set encoding=utf-8
scriptencoding utf-8

set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
set virtualedit=onemore         " allow for cursor beyond last character
set history=100                 " Store a ton of history (default is 20)
set hidden                      " allow buffer switching without saving

" Setting up the directories
set backup                      " backups are nice ...
if has('persistent_undo')
  set undofile                "so is persistent undo ...
  set undolevels=500         "maximum number of changes that can be undone
  set undoreload=500         "maximum number lines to save for undo on a buffer reload
endif

set tabpagemax=15               " only show 15 tabs
set showmode                    " display the current mode
set cursorline                  " highlight current line
set backspace=indent,eol,start  " backspace for dummies
set linespace=0                 " No extra spaces between rows
set nu                          " Line numbers on
set showmatch                   " show matching brackets/parenthesis
set hlsearch                    " highlight search terms
set winminheight=0              " windows can be 0 line high
set ignorecase                  " case insensitive search
set smartcase                   " case sensitive when uc present
set wildmenu                    " show list instead of just completing
set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " backspace and cursor keys wrap to
set scrolljump=5                " lines to scroll when cursor leaves screen
set scrolloff=3                 " minimum lines to keep above and below cursor
set list

" Formatting
set nowrap                                    " wrap long lines
set autoindent                                " indent at the same level of the previous line
set expandtab                                 " tabs are spaces, not tabs
set pastetoggle=<F12>                         " pastetoggle (sane indentation on pastes)
set listchars=tab:``,trail:`,extends:#,nbsp:` " Highlight problematic whitespace"
set shiftwidth=2                              " use indents of 2 spaces"
set tabstop=2                                 " an indentation every 2 columns"
set softtabstop=2                             " let backspace delete indent"

" Remove trailing whitespaces and ^M chars
autocmd FileType c,cpp,java,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
autocmd BufNewFile,BufRead *.jst.ejs set filetype=html

set notimeout      " timeout on mappings and key bindings"
set ttimeout       " timeout on mappings"
set timeoutlen=50

function! InitializeDirectories()
  let separator = "."
  let parent = $HOME
  let prefix = '.vim'
  let dir_list = {
              \ 'backup': 'backupdir',
              \ 'views': 'viewdir',
              \ 'swap': 'directory' }

  if has('persistent_undo')
    let dir_list['undo'] = 'undodir'
  endif

  for [dirname, settingname] in items(dir_list)
    let directory = parent . '/' . prefix . dirname . "/"
    if exists("*mkdir")
      if !isdirectory(directory)
        call mkdir(directory)
      endif
    endif
    if !isdirectory(directory)
      echo "Warning: Unable to create backup directory: " . directory
      echo "Try: mkdir -p " . directory
    else
      let directory = substitute(directory, " ", "\\\\ ", "g")
      exec "set " . settingname . "=" . directory
    endif
  endfor
endfunction
call InitializeDirectories()

set ttyfast
set t_Co=256
let base16colorspace=256
set background=dark
colorscheme base16-eighties
set guifont=Inconsolata-gz\ for\ Powerline:h12
let g:ctrlp_working_path=0
let g:ctrlp_max_files=0
set colorcolumn=80
