" Track that the plugin was loaded.
if exists('g:reverso#loaded')
    finish
endif
let g:reverso#loaded = 1
" let g:reverso#debug = 1

nnoremap <leader>t :call reverso#Spell()<CR>

command! -nargs=0 ReversoSpell call reverso#Spell()
