function Sed(find, replace)
    let l:files = systemlist('git grep -l -- '.shellescape(a:find))
    for l:file in l:files
        call nvim_command('edit ' . l:file)
        call nvim_command('%s/'.a:find.'/'.a:replace.'/g')
    endfor
endfunction
command! -nargs=2 Sed call Sed(<f-args>)
