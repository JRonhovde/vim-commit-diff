function! CloseCommitDiff()
  if tabpagenr('$') == 1
    let i = 1
    while i <= winnr('$')
      if bufname(winbufnr(i)) == 'CommitDiff'
        let i += 1
      else
        break
      endif
    endwhile
    if i == winnr('$') + 1
      qall!
    endif
    unlet i
  endif
endfunction


" commit diff
function! CommitDiff()
    35new CommitDiff
    r!git diff --cached
    setf diff
    call setpos('.', [0, 1, 1, 0])
    wincmd w
    call setpos('.', [0, 1, 1, 0])
endfunction


"Format commit message file layout
autocmd FileType gitcommit autocmd! VimEnter COMMIT_EDITMSG call CommitDiff()
autocmd FileType gitcommit autocmd! BufWritePost COMMIT_EDITMSG execute 'qa!'
autocmd BufEnter CommitDiff call CloseCommitDiff()
