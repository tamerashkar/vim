set nocompatible 											"We want the latest Vim settings/options.
source ~/.vim/plugins.vim

syntax enable
set backspace=indent,eol,start 								"Make backspace behave like every other editor.
"set complete=.,w,b,u 										"Set our desired autocompletion matching.
let mapleader = ',' 										"The default is \, but a comma is much better.
set nonumber 													"Let's activate line numbers.
"set relativenumber
set noerrorbells visualbell t_vb=               			"No damn bells!
set autochdir
set tags=tags;/
setlocal tabstop=2
setlocal shiftwidth=2
au BufNewFile,BufRead crontab.* set nobackup | set nowritebackup " when editting crontab

" A hidden buffer is a buffer with some unsaved modifications and is not displayed in a window.
set hidden

nnoremap [b :bp<cr>
nnoremap ]b :bn<cr>
nnoremap <leader>g :buffers<CR>:buffer<Space>
nnoremap <leader>gb <C-^>

noremap ; :
"noremap : ;

" FINDING FILES:
" @source: https://www.youtube.com/watch?v=XA2WjJbmmoM

" Search down into subfolders
set path+=**

" Display all matching files when we tab complete
set wildmenu
set wildignore+=*/vendor/*,*/node_modules/*,*/bower_components/*,*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux

" TAG JUMPING:
" @source: https://www.youtube.com/watch?v=XA2WjJbmmoM
command! MakeTags !ctags -R .
"

"-------------Visuals--------------"
"Credit joshdick
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
	if (has("nvim"))
	"For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
	let $NVIM_TUI_ENABLE_TRUE_COLOR=1
	endif
	"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
	"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
	" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
	if (has("termguicolors"))
		set termguicolors
	endif
endif


"colorscheme clarity
"colorscheme solarized
"colorscheme atom-dark
set background=dark
let g:airline_theme='one'
let g:one_allow_italics = 1
colorscheme one
set t_CO=<t_CO>															"Use <t_CO> colors. This is useful for Terminal Vim.
"set guifont=Fira_Code:h15												"Set the default font family and size.
"set guifont=Courier_Prime_Code:h15												"Set the default font family and size.
set guifont=OperatorMono-Book:h12												"Set the default font family and size.
set guioptions-=e														"We don't want Gui tabs.
set linespace=14   						        						"Macvim-specific line-height.

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set termguicolors

set guioptions-=l                                                       "Disable Gui scrollbars.
set guioptions-=L
set guioptions-=r
set guioptions-=R

" Set line number background same as background color.
highlight LineNr guibg=bg
" Fake a custom left padding for each window.
set foldcolumn=0
highlight foldcolumn guibg=bg
" Get rid of ugly split borders.
highlight vertsplit guifg=bg guibg=bg

let s:hidden_all = 1
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
    endif
endfunction

nnoremap <S-h> :call ToggleHiddenAll()<CR>


"-------------Search--------------"
set hlsearch                											"Highlight all matched terms.
set incsearch




"-------------Split Management--------------"
set splitbelow                 											"Make splits default to below...
set splitright                											"And to the right. This feels more natural.

nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-H> <C-W><C-H>
nmap <C-L> <C-W><C-L>

nnoremap ,v <C-w>v
nnoremap ,h <C-w>s
nnoremap ,, <C-w><C-w>


"-------------Mappings--------------"
"Make it easy to edit the Vimrc file.
nmap <Leader>ev :tabedit $MYVIMRC<cr>
nmap <Leader>es :e ~/.vim/snippets/
nmap <Leader>tts :1,$s/\t/  /g<cr>

"Add simple highlight removal.
nmap <Leader><space> :nohlsearch<cr>
set nohlsearch

" move by one line
nnoremap j gj
nnoremap k gk

"Ctags
"Quickly browse to any tag/symbol in the project.
"Tip: run ctags -R to regenerated the index.
nmap <Leader>f :tag<space>
nmap <leader>m <C-]>
nmap <leader>c <C-]>

"Quickly exit insert mode.
imap jk <Esc>
imap jj <Esc>

nmap tt :tabnew<CR>

" Quick save and quick file
imap <leader>w <esc>:w<CR>
nmap <leader>w :w<CR>
nmap <leader>q :q<CR>
nmap <leader>x :x<CR>

" Quick search and replace
nmap <leader>sr :%s/
vmap <leader>sr :s/

" Go to bash mode
nmap <leader>b :sh<CR>

"-------------Plugins--------------"
"/
"/ CtrlP
"/
let g:ctrlp_custom_ignore = 'mobile\|public\|vendors\|bower_components\|node_modules\|.DS_Store|git'
let g:ctrlp_match_window = 'top,order:ttb,min:1,max:30,results:30'
let g:ctrlp_max_files=10000

nmap <D-p> :CtrlP<cr>
nmap <d-r> :CtrlPBufTag<cr>
nmap <D-e> :CtrlPMRUFiles<cr>

"/
"/ NERDTree
let NERDTreeHijackNetrw = 0

"Make NERDTree easier to toggle.
nmap <D-1> :NERDTreeToggle<cr>

"/
"/ Syntastic
"/
let g:syntastic_php_checkers= ['php', 'phpcs'] " temporary took out phpmd
let g:syntastic_php_phpmd_post_args = 'controversial,design,unusedcode,' . $HOME . '/code/markettrader/phpmd.xml'
let g:syntastic_php_phpcs_args = '--standard=PSR2 -n'
nmap <leader>st :SyntasticToggleMode<CR>

"/
"/ phpDocumentor
"/
let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"
let g:pdv_cfg_Author = "Tamer Ashkar <me@tamerashkar.com>"
nnoremap <buffer> <leader>d :call pdv#DocumentWithSnip()<CR>
nnoremap <leader>pd :call pdv#DocumentWithSnip()<CR>

"/
"/ Taglist
"/
nnoremap <F8> :TlistToggle<CR>
nnoremap <leader>tt :TlistToggle<CR>

"/
"/ Tabular
"/
nmap <leader>a :Tabularize /=/<CR>
vmap <leader>a :Tabularize /=/<CR>
nmap <leader>aa :Tabularize /=>/<CR>
vmap <leader>aa :Tabularize /=>/<CR>
nmap <leader>o :Tabularize /:\zs/<CR>
vmap <leader>o :Tabularize /:\zs/<CR>

"/
"/ Emett
"/
let g:user_emmet_leader_key=',,'

"/
"/ Vim Markdown
"/
let g:vim_markdown_folding_disabled = 1

"/
"/ Goyo
"/
function! s:goyo_enter()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()

nnoremap <Leader>gy :Goyo<CR>
nmap <D-k>z :Goyo<cr>
"autocmd! User GoyoEnter Limelight
"autocmd! User GoyoLeave Limelight!
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'
let g:limelight_default_coefficient = 0.7

"
"/
"/ Ctags
"/
nmap <leader>. :tag<cr>

"/
"/ Testing
"/
nmap <silent> <leader>tm :TestNearest<CR> " t Ctrl+n
nmap <silent> <leader>tf :TestFile<CR>    " t Ctrl+f
nmap <silent> <leader>tp :TestLast<CR>    " t Ctrl+l
"nmap <silent> t<C-s> :TestSuite<CR>   " t Ctrl+s
"nmap <silent> t<C-g> :TestVisit<CR>   " t Ctrl+g

"/
"/ YouCompleteMe
"/
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0

"/
"/ Prettier
"/
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync

"-------------Angular/Typescript Specific--------------"
" Enable deoplete at startup
let g:deoplete#enable_at_startup = 1

"-------------Auto-Commands--------------"
"Automatically source the Vimrc file on save.

augroup autosourcing
  autocmd!
  autocmd BufWritePost .vimrc source %
augroup END

" Set Working Directory
" follow symlinked file
function! FollowSymlink()
  let current_file = expand('%:p')
  " check if file type is a symlink
  if getftype(current_file) == 'link'
    " if it is a symlink resolve to the actual file path
    "   and open the actual file
    let actual_file = resolve(current_file)
    silent! execute 'file ' . actual_file
  end
endfunction

"-------------Tips and Reminders--------------"
" - Press 'zz' to instantly center the line where the cursor is located.
" - Press 'ctrl-]' to go to method under cursor.
" - Press 'ctrl-^' takes you previous location.
" - Press 'c2t_' to cut up till '_' and go into insert mode.
" - Press 'f$' to move to next variable in PHP.
" - Press 'm<letter>' to set bookmark,
"   Press '`<letter>' to jump to that mark,
"   Press ''<leter>' to jump to line with the mark.
"   Note: lowercase letter sets to local buffer, uppercase letter is global.
"   Note: Pressing ':marks' will show your current marks.
"   After a mark has been set, you can
"   Press 'c`<letter>' to change text from cursor to the mark.
"   Press 'd`<letter>' to delete text from cursor to the mark.
"   Press '=`<letter>' to reformat lines from current to the mark.
" - Press 'gi" to go to insert mode where you left it last time.
"   Press 'c`<letter>' to change text from cursor to the mark.
