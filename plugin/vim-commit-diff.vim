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
    new CommitDiff
    set buftype=nofile
    r!git diff --cached
    setf diff
    call setpos('.', [0, 1, 1, 0])
    wincmd w
    if(winheight(0) + winheight(1)) > 40
        15wincmd _
    endif
    call setpos('.', [0, 1, 1, 0])
endfunction


"Format commit message file layout
autocmd FileType gitcommit autocmd! VimEnter COMMIT_EDITMSG call CommitDiff()
autocmd FileType gitcommit autocmd! BufWritePost COMMIT_EDITMSG execute 'q!' | call CloseCommitDiff()
autocmd BufEnter CommitDiff call CloseCommitDiff()
