"source ~/.config/nvim/vim-plug/plugins.vim
set noswapfile
set number
set relativenumber
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set splitright
set splitbelow
set undofile
set clipboard=unnamedplus
"
" begin for C++ Run and execute
"
" Set C++ file type
autocmd BufNewFile,BufRead *.cpp set filetype=cpp
 
" Compile and run C++ program in subshell
function! CompileAndRun()
  let autoSave = 'wa'
  exec autoSave

  let fileName = expand('%')
  if fileName =~ '\.cpp$'
    let exeName = substitute(fileName, '\.cpp$', '', '')
    let path = expand("%:p:h")
    execute 'w | !g++ -DLOCAL -std=c++17 -Wall -Wextra -Wpedantic -O2 -o ' . exeName . ' ' . fileName . ' && ' . path . '/./' . expand("%:t:r")
    if v:shell_error == 0
      let cmd = "x-terminal-emulator -e bash -c './" . exeName . "; read -p \"Press enter to exit...\"'"
      call system(cmd)
      redraw!
    endif
  else
    echo 'Not a C++ file'
  endif
endfunction

" For open input and Output File
function! InputOutputFile()
  let openInput = '60 vsp input.in'
  let openOutput = 'sp output.out'
  exec openInput
  exec openOutput
endfunction

" Map keys to compile and run current file
autocmd FileType cpp nnoremap <F5> :call CompileAndRun()<CR>
autocmd FileType cpp nnoremap <F9> :w<CR>:!clear<CR>:call CompileAndRun()<CR>
autocmd FileType cpp nnoremap <F2> :call InputOutputFile()<CR>
"
" end for C++ Run and execute
"
" begin for SystemVerilog Run and execute
"
function! RunVerilog()
  let fileName = expand('%')
  if fileName =~ '\.sv$'
    let exeName = substitute(expand("%:t"), '\.sv$', '', '')
    execute '!obj_dir/V' . exeName . ' > output.out 2>&1'
  else
    echo 'Not a SV file'
  endif
endfunction

function! CompileVerilog()
  let autoSave = 'wa'
  exec autoSave

  let fileName = expand('%')
  if fileName =~ '\.sv$'
    let exeName = substitute(fileName, '\.sv$', '', '')
    execute '!verilator --binary -j 0 -Wall ' . fileName
  else
    echo 'Not a SV file'
  endif
endfunction

" For open input and Output File
function! InputOutputFileVerilog()
  let openOutput = '60 vsp output.out'
  exec openOutput
endfunction

" Map keys to compile and run current file
autocmd BufReadPost,BufNewFile *.sv nnoremap <F2> :call InputOutputFileVerilog()<CR>
autocmd BufReadPost,BufNewFile *.sv nnoremap <F5> :call CompileVerilog()<CR>
autocmd BufReadPost,BufNewFile *.sv nnoremap <F9> :call RunVerilog()<CR>
"
" end for SystemVerilog Run and execute
