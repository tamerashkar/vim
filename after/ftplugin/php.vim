"\
"\ PHP specific settings.
"\
set nowrap                      " don't wrap lines
set tabstop=4                   " a tab is four spaces
set smarttab
set softtabstop=4               " when hitting <BS>, pretend like a tab is removed, even if spaces
set expandtab                   " expand tabs by default (overloadable per file type later)
set shiftwidth=4                " number of spaces to use for autoindenting
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
au BufEnter *.blade.php set ai sw=2 ts=2 sta et

"\
"\ Open Php Documentation
"\
function! BrowseDoc()
    ! open "http://php.net/<cword>"
endfunction
nmap K :call BrowseDoc()<CR>

" Php Refactoring
" vmap <leader>em :call ExtractMethod()<CR>
" nnoremap <leader>ev :call ExtractVariable()<CR>
" nnoremap <leader>ep :call ExtractClassProperty()<CR>
" nnoremap <leader>ei :call ExtractInterface()<CR>
" nnoremap <leader>rlv :call RenameLocalVariable()<CR>
" nnoremap <leader>rcv :call RenameClassVariable()<CR>
" nnoremap <leader>iaf :call ImplementAbstractFunctions()<CR>
" Extract Variable PHP
nmap <leader>ev 0<C-a> = <ESC>pa;



nmap <leader><leader>o :%s/\['\(.\{-}\)'\]/->\1/gc<CR> 	" Replace associative with object style notation


"\
"\ Php unit
"\
"nmap <leader>t :!clear && phpunit %<cr>
"nmap <leader>m yiw:!phpunit --filter ^R''<cr>

"\
"\ Laravel framework commons.
nmap <leader>lr :e app/Http/routes.php<cr>
nmap <leader>lca :e .env<cr>
nmap <leader>lc :e composer.json<cr>

function! PhpSyntaxOverride()
	hi! def link phpDocTags  phpDefine
	hi! def link phpDocParam phpType
endfunction

function! IPhpInsertUse()
	call PhpInsertUse()
	call feedkeys('a',  'n')
endfunction
autocmd FileType php inoremap <Leader>u <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>u :call PhpInsertUse()<CR>

augroup phpSyntaxOverride
	autocmd!
	autocmd FileType php call PhpSyntaxOverride()
augroup END

" Note: To add this to your .vimrc, you'll have to delete any character that is written with a caret (e.g. "^M") and enter the real value; to enter ^M, enter insert mode and type CTRL-V CTRL-M.

" Prepare a new PHP class
function! Class()
    let name = input('Class name? ')
    let namespace = input('Any Namespace? ')

    if strlen(namespace)
        exec "normal i<?php \n\n namespace " . namespace . ";\n\n"
    else
        exec "normal i<?php \n\n"
    endif

    " Open class
    exec "normal iclass " . name . " {\<C-m>}\<C-[>O\<C-[>"

    exec "normal i\<C-M>    public function __construct()\<C-M>{\<C-M>\<C-M>}\<C-[>"
endfunction
nmap ,1  :call Class()<cr>

function! AddDependency()
  let dependency = input('Var Name: ')
  let namespace = input('Class Path: ')

  let segments = split(namespace, '\')
  let typehint = segments[-1]

  exec 'normal gg/construct^M%i, '  . typehint . ' $' . dependency . '^[/}^MO$this->^[a' . dependency . ' = $' . dependency . ';^[==o^[?{^MkO  protected $' . dependency . ';^M^[?{^MOuse ' . namespace . ';^M^['

  " Remove opening comma if there is only one dependency
  exec 'normal :%s/(, /(/g^M'
endfunction
nmap <leader>2 :call AddDependency()<cr>

"/
"/ php-cs-fixer.vim
"/
" If php-cs-fixer is in $PATH, you don't need to define line below
" let g:php_cs_fixer_path = "~/php-cs-fixer.phar" " define the path to the php-cs-fixer.phar
let g:php_cs_fixer_level = "psr2"              " which level ?
nnoremap <silent><leader>pf :call PhpCsFixerFixFile()<CR>
