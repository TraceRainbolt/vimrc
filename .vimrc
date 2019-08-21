syntax on
filetype plugin indent on

" 4 Space tab
set tabstop=8
set softtabstop=4
set shiftwidth=4
set expandtab

inoremap jk <Esc>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>

set wildmode=longest,list,full
set wildmenu

" Hybrid line numbers
:set number relativenumber

" Turn off reletive line numbers in insert mode
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

" Place cursor at same line when reopening file
augroup line_return
    au!
    au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" Maps file completion relative to current file path.
inoremap <C-F>
    \ <C-O>:let b:oldpwd = getcwd() <bar>
    \ lcd %:p:h<cr><C-X><C-F>
" Restore path when done.
au CompleteDone *
    \ if exists('b:oldpwd') |
    \   cd `=b:oldpwd` |
    \   unlet b:oldpwd |
    \ endif

" Chain multiple path completions with / key. Selects the first suggestion if
" no current selection. Use ctrl-y to finish completion as normal.
imap <expr> / pumvisible()
    \ ? len(v:completed_item) ? '<C-Y><C-F>' : '<C-N><C-Y><C-F>'
    \ : '/'


