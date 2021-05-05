set nocompatible

set autoread

filetype plugin on
filetype indent on

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Makes search act like search in modern browsers
set incsearch

call plug#begin('~/.vim/plugged')
  Plug 'preservim/nerdtree'
"  Plug 'fatih/vim-go'
  Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-fugitive'
  Plug 'hashivim/vim-terraform'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'dense-analysis/ale'
  Plug 'morhetz/gruvbox'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'elixir-editors/vim-elixir'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  "Plug 'elixir-lsp/coc-elixir', {'do': 'yarn install && yarn prepack'}
  Plug 'vim-test/vim-test'
call plug#end()

set showcmd
set showmode
set showmatch

set number

set list
"set lcs=tab:→·,trail:»,space:·
set lcs=tab:→·,trail:»

set hlsearch
set incsearch

set wrap
set linebreak

"let g:go_fmt_command = "goimports"

let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'elixir': ['mix_format'],
\   'go': ['goimports', 'gofmt']
\}

" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0

if v:version >= 703
  set undodir=~/.vim/undofiles
  set undofile
  set colorcolumn=+1
endif

set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
set autoindent

set foldmethod=indent
set foldnestmax=3
set nofoldenable

set wildmode=list:longest
set wildmenu

set formatoptions-=o

set scrolloff=3
set sidescrolloff=7
set sidescroll=1

syntax enable
set background=dark
colorscheme gruvbox

"highlight the current line and column
set cursorline
set cursorcolumn
hi CursorLine term=bold cterm=bold

set t_Co=256

set hidden

" make gb select the last pasted text
nnoremap <expr> gb '`[' . strpart(getregtype(), 0, 1) . '`]'

inoremap jk <ESC>

" coc settings
if has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
 set signcolumn=number
else
 set signcolumn=yes
endif

" Use <c-space> to trigger completion.
if has('nvim')
 inoremap <silent><expr> <c-space> coc#refresh()
else
 inoremap <silent><expr> <c-@> coc#refresh()
endif

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" ================ Turn Off Swap Files ==============
set noswapfile
set nobackup
set nowb

"statusline setup
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1
set statusline=%#identifier#
set statusline+=[%t] "tail of the filename
set statusline+=%*

""display a warning if fileformat isnt unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

"display a warning if file encoding isnt utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set statusline+=%h "help file flag
set statusline+=%y "filetype

"read only flag
set statusline+=%#identifier#
set statusline+=%r
set statusline+=%*

"modified flag
set statusline+=%#identifier#
set statusline+=%m
set statusline+=%*
set statusline+=%{fugitive#statusline()}

"display a warning if &et is wrong, or we have mixed-indenting
set statusline+=%#error#
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*
set statusline+=%{StatuslineTrailingSpaceWarning()}
set statusline+=%{StatuslineLongLineWarning()}
set statusline+=%#warningmsg#
set statusline+=%*

"display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

set statusline+=%= "left/right separator
set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
set statusline+=%c, "cursor column
set statusline+=%l/%L "cursor line/total lines
set statusline+=\ %P "percent through file
set laststatus=2

let g:vim_markdown_folding_disabled=1
let g:notes_directories = ['~/notes']
let g:notes_shadowdir = "~/.vim/bundle/vim-notes/misc/notes/shadow/"

autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

"Remap FZF to leader . for ease of use
nnoremap <leader>. :FZF<cr>
nnoremap <leader>b :Buffer .<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" Test shortcuts
let test#strategy = "dispatch"
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>

"Encryption Parameters
set cm=blowfish2
set viminfo=
set nobackup
set nowritebackup

function! StatuslineTrailingSpaceWarning()
  if !exists("b:statusline_trailing_space_warning")
    if !&modifiable
      let b:statusline_trailing_space_warning = ''
      return b:statusline_trailing_space_warning
    endif
    if search('\s\+$', 'nw') != 0
      let b:statusline_trailing_space_warning = '[\s]'
    else
      let b:statusline_trailing_space_warning = ''
    endif
  endif
  return b:statusline_trailing_space_warning
endfunction

function! StatuslineCurrentHighlight()
  let name= synIDattr(synID(line('.'),col('.'),1),'name')
  if name == ''
    return ''
  else
    return '['.name.']'
  endif
endfunction

"recalculate the tab warning flag when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

function! StatuslineTabWarning()
  if !exists("bLstatusline_tab_warning")
    let b:statusline_tab_warning = ''

    if !&modifiable
      return b:statusline_tab_warning
    endif
    let tabs = search('Z^\t', 'nw') != 0

    let spaces = search('!^\{' . &ts . ',}[^\t]', 'nw') != 0

    if tabs && spaces
      let b:statusline_tab_warning = '[mixed-indenting]'
    elseif (spaces && !&et) || (tabs && &et)
      let b:statusline_tab_warning = '[&et]'
    endif
    return b:statusline_tab_warning
endfunction

"recalculate the long line warning when idle and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning

function! StatuslineLongLineWarning()
  if !exists("b:statusline_long_line_warning")

    if !&modifiable
      let b:statusline_long_line_warning = ''
      return b:statusline_long_line_warning
    endif

    let long_line_lens = s:LongLines()
    if len(long_line_lens) > 0
      let b:statusline_long_line_warning = "[" .
            \ '#' . len(long_line_lens) . "," .
            \ 'm' . s:Median(long_line_lens) . "," .
            \ '$' . max(long_line_lens) . "]"
    else
      let b:statusline_long_line_warning = ""
    endif
  endif
  return b:statusline_long_line_warning
endfunction

"return a list containing the lengths of the long lines in this buffer
function! s:LongLines()
  let threshold = (&tw ? &tw : 80)
  let spaces = repeat(" ", &ts)
  let line_lens = map(getline(1,'$'), 'len(substitute(v:val, "\\t", spaces, "g"))')
  return filter(line_lens, 'v:val > threshold')
endfunction

"find the median of the given array of numbers
function! s:Median(nums)
  let nums = sort(a:nums)
  let l = len(nums)
  if l % 2 == 1
    let i = (l-1) / 2
    return nums[i]
  else
    return (nums[l/2] + nums[(l/2)-1]) / 2
  endif
endfunction

"nerdtree settings
let g:NERDTreeMouseMode = 2
let g:NERDTreeWinSize = 40
"
"explorer mappings
nnoremap <f2> :NERDTreeToggle<cr>
nnoremap <f3> :Explore<cr>

"resizing helpers
nnoremap <silent> + :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> - :exe "resize " . (winheight(0) * 2/3)<CR>

"dont load csapprox if we no gui support - silences an annoying warning
if !has("gui")
  let g:CSApprox_loaded = 1
endif

"make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

set encoding=utf-8
setglobal fileencoding=utf-8
set fileencodings=utf-8
set termencoding=utf-8

"LaTeX settings
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"
