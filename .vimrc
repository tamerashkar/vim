set nocompatible 											"We want the latest Vim settings/options.
source ~/.vim/plugins.vim

syntax enable
set backspace=indent,eol,start 								"Make backspace behave like every other editor.
set background=dark
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

nnoremap <leader>g :buffers<CR>:buffer<Space>
nnoremap <leader>gb <C-^>

"-------------Visuals--------------"
"colorscheme atom-dark
colorscheme solarized
"colorscheme clarity
"colorscheme github
set t_CO=<t_CO>															"Use <t_CO> colors. This is useful for Terminal Vim.
"set guifont=Fira_Code:h15												"Set the default font family and size.
"set guifont=Courier_Prime_Code:h15												"Set the default font family and size.
set guifont=PragmataPro:h15												"Set the default font family and size.
set guioptions-=e														"We don't want Gui tabs.
set linespace=15   						        						"Macvim-specific line-height.

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

let s:hidden_all = 0
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

"Add simple highlight removal.
nmap <Leader><space> :nohlsearch<cr>

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
set wildignore+=*/vendor/*,*/node_modules/*,*/bower_components/*,*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
let g:ctrlp_custom_ignore = 'mobile\|public\|vendors\|bower_components\|node_modules\|.DS_Store|git'
let g:ctrlp_match_window = 'top,order:ttb,min:1,max:30,results:30'
let g:ctrlp_max_files=0

nmap <D-p> :CtrlP<cr>
nmap <D-r> :CtrlPBufTag<cr>
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
"/ Vim Markdown
"/
let g:vim_markdown_folding_disabled = 1

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
