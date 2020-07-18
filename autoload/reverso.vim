if exists('g:reverso#autoloaded')
    finish
endif
let g:reverso#autoloaded = 1

" reversoSpell takes in either the visual selection of text or the line the
" cursor is currently on (if there is no visual selection) and appends the
" completed text from the reverso API.
function! reverso#Spell()
    " Get the position of the cursor, if it is the start of the file we want
    " a different behavior than if it is elsewhere.
    let end_line = getpos("'>'")[1]
    let l:text = reverso#GetVisualSelection()
    if len(l:text) < 1
        " Get the current line instead.
        let l:text = getline(".")
    endif

    " Set search language "fra" or "eng" available
    let g:reverso#search_lang = "fra"
    let l:command = "curl "
    let l:command .= "'"
    let l:command .= "https://orthographe.reverso.net/RISpellerWS/RestSpeller.svc/v1/CheckSpellingAsXml/language=". g:reverso#search_lang
    let l:command .= "?outputFormat=json"
    let l:command .= "&doReplacements=true"
    let l:command .= "&interfLang=fr"
    let l:command .= "&dictionary=both"
    let l:command .= "&spellOrigin=interactive"
    let l:command .= "&includeSpellCheckUnits=true"
    let l:command .= "&includeExtraInfo=false"
    let l:command .= "&isStandaloneSpeller=true"
    let l:command .= "' "
    let l:command .= "-H 'username: OnlineSpellerWS' "
    let l:command .= "-H 'created: 01/01/0001 00:00:00' "
    let l:command .= "--data \"" . substitute(trim(l:text), '"', '\\"', "g") . "\" "
    let l:output = trim(system(l:command ." | jq --raw-output .AutoCorrectedText"))
    let l:replace = ":%s/" . substitute(trim(l:text), '¤', '\\n', "g") . "/"
    " see https://stackoverflow.com/questions/71323/how-to-replace-a-character-by-a-newline-in-vim/71334#71334
    let l:replace .= substitute(trim(l:output), '¤', '\\r', "g") . "/g"
    if exists('g:reverso#debug')
        echo l:command
        echo ">>> " . l:output
        echo ">>> " . l:replace
    endif

    execute l:replace
endfunction

" reverso#GetVisualSelection returns the text in a visual selection.
" See: https://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript/6271254#6271254
function! reverso#GetVisualSelection()
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    let clean_lines = []
    for line in lines
        let clean_lines += [substitute(trim(line), '\n', '', 'g')]
    endfor
    return join(clean_lines, "¤")
endfunction
