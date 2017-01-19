" Load plugins with multi-threading
let g:plug_threads = 25
call plug#begin('~/.vim/plugged')

" Display
Plug 'ap/vim-buftabline'  " Show buffers in tabline
Plug 'itchyny/lightline.vim'  " Improved and lightweight statusline
Plug 'nathanaelkane/vim-indent-guides'  " Indent guides
Plug 'tomasr/molokai'  " Dark and colorful colorscheme

" Visual aids for builtin features
Plug 'pgdouyon/vim-evanesco'  " Improved search highlighting
Plug 'kana/vim-operator-user' | Plug 'haya14busa/vim-operator-flashy'  " Yank
Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}  " Undotree
Plug 'unblevable/quick-scope'  " f/t targets

" Editing
Plug 'sickill/vim-pasta'  " Context aware pasting
Plug 'tpope/vim-abolish'  " More powerful substitute command
Plug 'tpope/vim-commentary'  " Commenting and uncommenting
Plug 'wellle/targets.vim'  " Seeking for pair text objects and new text objects

" Surroundings
Plug 'Valloric/MatchTagAlways'  " Highlight tags when inside
Plug 'justinmk/vim-matchparenalways'  " Highlight parentheses when inside
Plug 'tpope/vim-surround'  " Text objects for surroundings

" Integration with external programs
Plug 'airblade/vim-gitgutter'  " Git diff in the gutter
Plug 'scrooloose/syntastic'  " Linting integration

" Other
Plug 'ajh17/VimCompletesMe'  " Simple tab completion in insert mode
Plug 'ctrlpvim/ctrlp.vim' | Plug 'FelikZ/ctrlp-py-matcher'  " Fuzzy finder
Plug 'vim-utils/vim-husk'  " Emacs keybindings for command-line mode

" Python
Plug 'hdima/python-syntax', {'for': 'python'}  " Improved syntax highlighting
Plug 'hynek/vim-python-pep8-indent', {'for': 'python'}  " PEP8 indenting

" Other languages
Plug 'othree/html5.vim', {'for': 'html'}  " HTML5 syntax highlighting

call plug#end()

" Extended % matching for HTML tags, if/else statements, etc.
runtime macros/matchit.vim

" Group for all autocmd commands
augroup rc
  autocmd!
augroup END

" Colorscheme
colorscheme molokai
highlight IncSearch ctermfg=118 guifg=#87ff00
highlight Normal ctermbg=none  " Use terminal background
highlight Visual ctermbg=238  " Visual selection background
highlight SpellBad cterm=underline ctermfg=red ctermbg=none
highlight SpellLocal cterm=underline ctermfg=blue ctermbg=none

" Display
set colorcolumn=+0  " Draw a vertical line at the value of textwidth
set laststatus=2  " Always display the statusline
set noerrorbells visualbell t_vb=  " Disable visual and error bells
set relativenumber number  " Relative line numbers except for the current line
set spell spelllang=en_us  " Spell checking

" GUI specific configuration
set guicursor+=a:blinkon0 guioptions=  " Non-blinking cursor, minimal UI
set guifont=Ubuntu\ Mono\ 12  " Font
autocmd rc GUIEnter * set t_vb=  " Disable bells (autocmd since GUI resets it)

" Visual line wrapping
set linebreak  " Wrap long lines by words instead of the last character
if exists('+breakindent')  " Indent wrapped lines as previous lines (7.4.338+)
    set breakindent
endif

" Indentation
set autoindent  " Use current indentation for new lines
set expandtab shiftwidth=0 softtabstop=-1  " Shift, add/delete spaces, not tabs
set tabstop=4  " Number of spaces that a tab counts for

" Formatting
set nojoinspaces  " Don't insert 2 spaces after punctuation when joining lines
set textwidth=79  " Maximum width to break lines (specified by formatoptions)

" Comment formatting: auto-wrap, remove leader with join or 'gq'
set formatoptions=cqj
autocmd rc FileType * setlocal formatoptions=cqj  " Override filetype plugins

" Searching
set ignorecase smartcase  " Case insensitive if lowercase, sensitive otherwise
set incsearch  " Search as pattern is entered

" Buffers/files
set autochdir  " Change working directory to currently open file
set autoread  " Auto-reload files when they change without prompting
set hidden  " Allow buffers to be hidden without being saved

" Command-line completions
set wildignore=*.pyc,*.min.*,*.map  " Ignore file patterns in completions
set wildignorecase  " Case insensitive filename completions
set wildmenu  " Show list of possible completions above command-line

" Insert mode completions
set completeopt=longest  " Insert common text of matches on first completion
set completeopt+=menuone  " Display menu, even if only one match

" Other
set clipboard=unnamedplus  " Use system clipboard for copying and pasting
set directory=~/.vim/swap  " Keep swap files out of current directory

" Filetype specific configuration
autocmd BufNewFile,BufRead *.html set filetype=htmldjango  " Django HTML syntax
autocmd rc FileType css,htmldjango,javascript,json setlocal tabstop=2

" Disable Ex mode
nnoremap Q <nop>

" Split management
nnoremap <silent> <a-h> <c-w>h<c-w>k
nnoremap <silent> <a-j> <c-w>j
nnoremap <silent> <a-k> <c-w>k
nnoremap <silent> <a-l> <c-w>l<c-w>k
nnoremap <a-v> :vsplit<CR>

" Buffer management
nnoremap <a-n> :bnext<CR>
nnoremap <a-p> :bprevious<CR>
command! D bprevious | bdelete #  " Delete the buffer without closing the split
command! Da bufdo bdelete  " Delete all buffers

" Trailing whitespace
autocmd rc BufEnter * match SpellBad '\s\+$'  " Highlight trailing whitespace
command! DeleteTrailing %s/\s\+$//e  " Delete all trailing whitespace

" Buftabline
let g:buftabline_indicators = 1  " Show saved indicator
let g:buftabline_numbers = 1  " Show buffer numbers

" Lightline
let g:lightline = {'active': {
    \ 'left': [['readonly', 'absolutepath', 'modified']],
    \ 'right': [['lineinfo'], ['percent'], ['filetype']]}}

" Indent Guides
let g:indent_guides_enable_on_vim_startup = 1  " Enable on startup
let g:indent_guides_guide_size = 1  " Use thin guides
let g:indent_guides_start_level = 2  " Don't show guides for the first indent

" Oblique
let g:oblique#incsearch_highlight_all = 1  " Highlight all incremental searches

" Operator-flashy
map y <Plug>(operator-flashy)
nmap Y <Plug>(operator-flashy)$
let g:operator#flashy#flash_time = 1000  " Show highlight for one second

" Quick-scope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']  " Only highlight on f/t

" Pasta
let g:pasta_disabled_filetypes = []  " Enable for all filetypes

" Syntastic
let g:syntastic_python_checkers = ['python', 'flake8']
let g:syntastic_sh_checkers = ['sh', 'shellcheck']
let g:syntastic_vim_checkers = ['vint']

" CtrlP
let g:ctrlp_match_func = {'match': 'pymatcher#PyMatch'}  " Use a faster matcher
let g:ctrlp_match_window = 'order:ttb,max:20'  " Show 20 results, top to bottom
let g:ctrlp_prompt_mappings = {
    \ 'PrtSelectMove("j")': ['<tab>'], 'PrtSelectMove("k")': ['<s-tab>'],
    \ 'PrtExpandDir()': [], 'ToggleFocus()': []}  " Use tab/shift-tab to select
if executable('rg')  " Use ripgrep if it's installed and don't cache
    let g:ctrlp_user_command = 'rg --files %s --color=never'
    let g:ctrlp_use_caching = 0
end
nnoremap <a-b> :CtrlPBuffer<cr>

" Python syntax
let g:python_highlight_all = 1  " Use all custom highlighting
