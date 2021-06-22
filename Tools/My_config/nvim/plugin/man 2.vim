" ============================================================================
" FileName: man.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" Description: overwrite $VIMRUNTIME/plugin/man.vim for better completion
" ============================================================================

if exists('g:loaded_man')
  finish
endif
let g:loaded_man = 1

command! -bang -bar -range=-1 -complete=customlist,mancompl#complete -nargs=* Man
      \ if <bang>0 | set ft=man |
      \ else | call man#open_page(<count>, <q-mods>, <f-args>) | endif

augroup man
  autocmd!
  autocmd BufReadCmd man://* call man#read_page(matchstr(expand('<amatch>'), 'man://\zs.*'))
augroup END
