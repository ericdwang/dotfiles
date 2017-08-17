" Load plugins with multi-threading
let g:plug_threads = 20
call plug#begin('~/.vim/plugged')

" Display
Plug 'ap/vim-buftabline'  " Show buffers in tabline
Plug 'nathanaelkane/vim-indent-guides'  " Indent guides
Plug 'tomasr/molokai'  " Dark and colorful colorscheme

" Visual aids for builtin features
Plug 'machakann/vim-highlightedyank'  " Yank highlighting
Plug 'mbbill/undotree'  " Visual undo tree
Plug 'pgdouyon/vim-evanesco'  " Improved search highlighting
Plug 'unblevable/quick-scope'  " f/t targets

" Editing
Plug 'sickill/vim-pasta'  " Context aware pasting
Plug 'tpope/vim-abolish'  " More powerful substitute command
Plug 'tpope/vim-commentary'  " Commenting and uncommenting
Plug 'wellle/targets.vim'  " Seeking for pair text objects and new text objects

" Surroundings
Plug 'Valloric/MatchTagAlways'  " Highlight tags when inside
Plug 'justinmk/vim-matchparenalways'  " Highlight parentheses when inside
Plug 'luochen1990/rainbow'  " Rainbow parentheses
Plug 'tpope/vim-surround'  " Text objects for surroundings

" Integration with external programs
Plug 'airblade/vim-gitgutter'  " Git diff in the gutter
Plug 'w0rp/ale'  " Asynchronous linting integration

" Other
Plug 'ajh17/VimCompletesMe'  " Simple tab completion in insert mode
Plug 'hdima/python-syntax'  " Improved Python syntax highlighting
Plug 'vim-utils/vim-husk'  " Emacs keybindings for command-line mode

call plug#end()

" Extended % matching for HTML tags, if/else statements, etc.
runtime macros/matchit.vim

" Group for all autocmd commands
augroup rc
  autocmd!
augroup END

" Display
colorscheme molokai
highlight Visual ctermbg=238  " Visual selection background
set colorcolumn=+0  " Draw a vertical line at the value of textwidth
set relativenumber number  " Relative line numbers except for the current line
set showcmd  " Display current command in bottom right corner

" Statusline: readonly, full path, modified, filetype, percentage, line+column
set laststatus=2  " Always display statusline
set statusline=%r\ %F\ %m\ %=\ %{&ft!=#''?&ft:'no\ ft'}\ \|\ %p%%\ \|\ %l:%c

" GUI and terminal specific configuration
if has('gui_running')
    set guicursor+=a:blinkon0 guioptions=  " Non-blinking cursor, minimal UI
    set guifont=Monospace\ 12
else
    highlight Normal ctermbg=NONE guibg=NONE  " Use terminal background

    " Enable 24-bit true colors for non-xterm TERM values (:h xterm-true-color)
    if exists('+termguicolors')  " Vim 7.4.1799+
        set termguicolors
        let &t_8f = "\e[38;2;%lu;%lu;%lum"
        let &t_8b = "\e[48;2;%lu;%lu;%lum"
    endif
endif

" Visual line wrapping
set linebreak  " Wrap long lines by words instead of the last character
if exists('+breakindent')  " Vim 7.4.338+
    set breakindent  " Indent wrapped lines the same level as the starting line
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
highlight IncSearch ctermfg=118 guifg=#87ff00

" Buffers/files
set autoread  " Auto-reload files when they change without prompting
set hidden  " Allow buffers to be hidden without being saved

" Command-line completions
set wildignore=*/,*.pyc,*.min.*,*.map  " Ignore directories and certain files
set wildignorecase  " Case insensitive filename completions
set wildmenu  " Show list of possible completions above command-line

" Insert mode completions
set completeopt=longest  " Insert common text of matches on first completion
set completeopt+=menuone  " Display menu, even if only one match

" Spell checking
set spell spelllang=en_us  " Enable and set language
highlight SpellBad cterm=underline ctermbg=NONE
highlight SpellCap cterm=underline ctermbg=NONE
highlight SpellLocal cterm=underline ctermbg=NONE
highlight SpellRare cterm=underline ctermbg=NONE

" Other
set clipboard=unnamedplus  " Use system clipboard for copying and pasting
set directory=~/.vim/swap  " Keep swap files out of current directory

" Filetype specific configuration
autocmd BufNewFile,BufRead *.html set syntax=htmldjango  " Django HTML syntax
autocmd rc FileType css,html,htmldjango,javascript,json setlocal tabstop=2
let g:pyindent_open_paren = shiftwidth()  " Indent one tab after open parens

" Change cursor shape depending on mode
let &t_EI = "\e[2 q"  " Normal mode: block
let &t_SI = "\e[6 q"  " Insert mode: line
if exists('&t_SR')  " Vim 7.4.687+
    let &t_SR = "\e[4 q"  " Replace mode: underline
endif

" Open a file in any subdirectory starting with any letters in the filename
nnoremap <a-o> :edit **/*

" List all buffers and select by number or filename with tab completion
nnoremap <a-b> :ls<cr>:buffer<space>

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
let g:buftabline_show = 1  " Only show tabline if there's at least two buffers

" Indent Guides
let g:indent_guides_enable_on_vim_startup = 1  " Enable on startup
let g:indent_guides_guide_size = 1  " Use thin guides
let g:indent_guides_start_level = 2  " Don't show guides for the first indent

" Highlightedyank
map y <Plug>(highlightedyank)
nmap Y <Plug>(highlightedyank)$
let g:highlightedyank_highlight_duration = 200  " Show highlight for 200ms

" Quick-scope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']  " Only highlight on f/t

" Pasta
let g:pasta_disabled_filetypes = []  " Enable for all filetypes

" Rainbow
let g:rainbow_active = 1  " Always start rainbow
let g:rainbow_conf = {'separately': {
    \ 'html': 0, 'htmldjango': 0, 'xml': 0}}  " Disable for some filetypes
" Fix spell check being enabled in parentheses where it shouldn't
autocmd rc FileType * syntax cluster rainbow_r0 add=@NoSpell

" Git Gutter
let g:gitgutter_eager = 0  " Don't run after refocusing on buffer
let g:gitgutter_realtime = 0  " Don't run when editor is idle without saving

" ALE
let g:ale_lint_on_text_changed = 'never'  " Only run when changes are saved
let g:ale_lint_on_enter = 0  " Don't run after opening files
nmap [e <Plug>(ale_previous)
nmap ]e <Plug>(ale_next)

" Python syntax
let g:python_highlight_all = 1  " Use all custom highlighting
