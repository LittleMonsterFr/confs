syntax on
set background=dark
colorscheme solarized
highlight TrailingWhitespace ctermbg=red guibg=red
match TrailingWhitespace /\s\+$/
set shiftwidth=2
set textwidth=72
set tabstop=8
set expandtab
set smarttab
set smartindent
set softtabstop=2
set scrolloff=5
set number
set mouse=a
filetype plugin indent on
set mousehide
set cursorline
set hidden
set nocompatible
set backspace=indent,eol,start

"The two following lines are linked
set list
set lcs=tab:(-,eol:£

au BufRead,BufNewFile *.aasm set filetype=aasm

" Auto include gates for headers files
function! s:insert_gates()
let gatename = substitute(substitute(toupper(expand("%:t")), "\\.", "_", "g"), "\\-", "_", "g")
execute "normal! i#ifndef " . gatename
execute "normal! o# define " . gatename
execute "normal! o"
execute "normal! Go#endif /* !" . gatename . " */"
normal! kk
endfunction
autocmd BufNewFile *.{h,hpp,hh,hxx} call <SID>insert_gates()
