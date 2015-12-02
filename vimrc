""""""""""""""""""""""""""""""""""""""""""""""""""""""
" All Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.vim/plugged')

" Solarized Colorscheme
Plug 'altercation/vim-colors-solarized'

" Remove Trailing Whitespaces
Plug 'bronson/vim-trailing-whitespace'

" File Management
Plug 'Shougo/vimproc.vim'
Plug 'Shougo/unite.vim'
Plug 'rking/ag.vim'

" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Align
Plug 'junegunn/vim-easy-align'

" ---------- VERY IMPORTANT -----------
" Don't forget to install ghc-mod with:
" cabal install ghc-mod
" -------------------------------------

Plug 'scrooloose/syntastic'             " syntax checker
" --- Haskell
Plug 'yogsototh/haskell-vim'            " syntax indentation / highlight
" Plug 'enomsg/vim-haskellConcealPlus'    " unicode for haskell operators
Plug 'eagletmt/ghcmod-vim'
Plug 'eagletmt/neco-ghc'
Plug 'Twinside/vim-hoogle'
" Plug 'pbrisbin/html-template-syntax'    " Yesod templates

call plug#end()


""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorscheme (Yann)
""""""""""""""""""""""""""""""""""""""""""""""""""""""

" -- solarized personal conf
set background=light
try
    colorscheme solarized
catch
endtry


""""""""""""""""""""""""""""""""""""""""""""""""""""""
" See the 80th Column (Yann)
""""""""""""""""""""""""""""""""""""""""""""""""""""""

if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight ColorColumn ctermbg=9
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File Management (Yann)
"
" Unite
"   depend on vimproc
"   ------------- VERY IMPORTANT ------------
"   you have to go to .vim/plugin/vimproc.vim and do a ./make
"   -----------------------------------------
""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:unite_source_history_yank_enable = 1
try
  let g:unite_source_rec_async_command='ag --nocolor --nogroup -g ""'
  call unite#filters#matcher_default#use(['matcher_fuzzy'])
catch
endtry
" search a file in the filetree
" nnoremap <space><space> :vsplit<cr> :<C-u>Unite -start-insert file_rec/async<cr>
nnoremap <space><space> :<C-u>Unite -start-insert file_rec/async<cr>
" reset not it is <C-l> normally
:nnoremap <space>r <Plug>(unite_restart)

"""""""""""
" Using ag
"""""""""""

" --- type ° to search the word in all files in the current dir
nmap & :Ag <c-r>=expand("<cword>")<cr><cr>
nnoremap <space>/ :Ag 


""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Align Things (Yann)
""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Easy align interactive
vnoremap <silent> <Enter> :EasyAlign<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Haskell
""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader=","
let g:mapleader=","
set tm=2000
nmap <silent> <leader>ht :GhcModType<CR>
nmap <silent> <leader>hh :GhcModTypeClear<CR>
nmap <silent> <leader>hT :GhcModTypeInsert<CR>
nmap <silent> <leader>hc :SyntasticCheck ghc_mod<CR>:lopen<CR>
let g:syntastic_mode_map={'mode': 'active', 'passive_filetypes': ['haskell']}
let g:syntastic_always_populate_loc_list = 1
nmap <silent> <leader>hl :SyntasticCheck hlint<CR>:lopen<CR>

" Auto-checking on writing
autocmd BufWritePost *.hs,*.lhs GhcModCheckAndLintAsync

"  neocomplcache (advanced completion)
autocmd BufEnter *.hs,*.lhs let g:neocomplcache_enable_at_startup = 1
function! SetToCabalBuild()
    if glob("*.cabal") != ''
        set makeprg=cabal\ build
    endif
endfunction
autocmd BufEnter *.hs,*.lhs :call SetToCabalBuild()

" -- neco-ghc
let $PATH=$PATH.':'.expand("~/.cabal/bin")


""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Latex
""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Insert latex itemize
function! Itemize()
    call append(line('.'), "\\end{itemize}")
    call append(line('.'), "\\item")
    call append(line('.'), "\\begin{itemize}")
endfunction
nmap <silent> <leader>item :call Itemize()<CR>

" Insert latex block
function! Block()
    call append(line('.'), "\\end{block}")
    call append(line('.'), "\\begin{block}{}")
endfunction
nmap <silent> <leader>block :call Block()<CR>

" Compile the current file
nmap <silent> <leader>comp :silent !pdflatex %<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Personal
""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype plugin on
syntax on

" indentation
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set textwidth=79

" inverse tab:
" for command mode
nmap <S-Tab> <<
" for insert mode
imap <S-Tab> <Esc><<i

" correct highlighting for partial latex files
let g:tex_flavor = "latex"

" Toggling the display of widgets
nnoremap <C-F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
nnoremap <C-F2> :if &go=~#'T'<Bar>set go-=T<Bar>else<Bar>set go+=T<Bar>endif<CR>
nnoremap <C-F3> :if &go=~#'L'<Bar>set go-=L<Bar>else<Bar>set go+=L<Bar>endif<CR>
nnoremap <C-F4> :if &go=~#'r'<Bar>set go-=r<Bar>else<Bar>set go+=r<Bar>endif<CR>
" Widgets hidden by default
set go-=m
set go-=T
set go-=L
set go-=r

" Setting font and its size
set guifont=Monospace\ 11
