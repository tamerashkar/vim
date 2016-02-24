set nocompatible              						"We want the latest Vim settings/options.

source ~/.vim/plugins.vim

syntax enable
set backspace=indent,eol,start                                          "Make backspace behave like every other editor.
let mapleader = ',' 						    	"The default is \, but a comma is much better.
set number								"Let's activate line numbers.
set relativenumber
set autochdir
set tags=tags;/

"-------------Visuals--------------"
colorscheme atom-dark
set t_CO=<t_CO>								"Use <t_CO> colors. This is useful for Terminal Vim.
set guifont=Fira_Code:h15						"Set the default font family and size.
set guioptions-=e							"We don't want Gui tabs.
set linespace=10   						        "Macvim-specific line-height.

set guioptions-=l                                                       "Disable Gui scrollbars.
set guioptions-=L
set guioptions-=r
set guioptions-=R

" Set line number background same as background color.
highlight LineNr guibg=bg
" Fake a custom left padding for each window.
set foldcolumn=1
highlight foldcolumn guibg=bg
" Get rid of ugly split borders.
highlight vertsplit guifg=bg guibg=bg

"-------------Search--------------"
set hlsearch                "Highlight all matched terms.
set incsearch




"-------------Split Management--------------"
set splitbelow                 "Make splits default to below...
set splitright                "And to the right. This feels more natural.

"We'll set simpler mappings to switch between splits.
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-H> <C-W><C-H>
nmap <C-L> <C-W><C-L>



"-------------Mappings--------------"
"Make it easy to edit the Vimrc file.
nmap <Leader>ev :tabedit $MYVIMRC<cr>
nmap <Leader>es :e ~/.vim/snippets/

"Add simple highlight removal.
nmap <Leader><space> :nohlsearch<cr>

"Quickly browse to any tag/symbol in the project.
"Tip: run ctags -R to regenerated the index.
nmap <Leader>f :tag<space>

"Quickly exit insert mode.
imap jk <Esc>

"-------------Plugins--------------"
"/
"/ CtrlP
"/
set wildignore+=*/vendor/*,*/node_modules/*,*/bower_components/*,*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
let g:ctrlp_custom_ignore = 'mobile\|public\|vendors\|bower_components\|node_modules\|.DS_Store|git'
let g:ctrlp_match_window = 'top,order:ttb,min:1,max:30,results:30'
let g:ctrlp_max_files=0

nmap <D-p> :CtrlP<cr>
nmap <D-r> :CtrlPBufTag<cr>
nmap <D-e> :CtrlPMRUFiles<cr>

"/
"/ NERDTree
"/
let NERDTreeHijackNetrw = 0

"Make NERDTree easier to toggle.
nmap <D-1> :NERDTreeToggle<cr>

"/
"/ Syntastic
"/
let g:syntastic_php_checkers=['php', 'phpcs', 'phpmd']
let g:syntastic_php_phpcs_args='--standard=PSR2 -n'
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

"/
"/ Tabular
"/
if exists(":Tabularize")
 nmap <leader><leader>= :Tabularize /=<CR>
 vmap <leader><leader>= :Tabularize /=<CR>
 nmap <leader><leader>a :Tabularize /=>/<CR>
 vmap <leader><leader>a :Tabularize /=>/<CR>
 nmap <leader><leader>: :Tabularize /:\zs<CR>
 vmap <leader><leader>: :Tabularize /:\zs<CR>
endif

"-------------Laravel-Specific--------------"
nmap <leader>lr :e app/routes.php<cr>
nmap <leader><leader>c :CtrlP<cr>app/controllers/
nmap <leader><leader>m :CtrlP<cr>app/models/
nmap <leader><leader>w :CtrlP<cr>app/Wsio/
nmap <leader><leader>v :CtrlP<cr>app/views/
nmap <leader><leader>r :CtrlP<cr>app/resources/


"-------------Auto-Commands--------------"
"Automatically source the Vimrc file on save.

augroup autosourcing
  autocmd!
  autocmd BufWritePost .vimrc source %
augroup END

" Automatically strip trailing whitespace on save.
autocmd BufWritePre * :%s/\s\+$//e


"-------------Tips and Reminders--------------"
" - Press 'zz' to instantly center the line where the cursor is located.
" - Press 'ctrl-]' to go to method under cursor.
" - Press 'ctrl-^' takes you previous location.
" - Press 'cs<letter><replacement>' to replace surrounding text.
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
