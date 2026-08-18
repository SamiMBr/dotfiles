""" use Enter to select coc completion
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

""" use Tab to select and move forward coc completions
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

""" use Shift-Tab to move backward coc completions
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

""" use Ctrl-K to trigger completion when not shown
inoremap <silent><expr> <C-k> coc#refresh()

"" Enable coc ansible on yaml.ansible and yaml filetypes extensions
let g:coc_filetype_map = {
  \ 'yaml.ansible': 'ansible',
  \ 'yaml': 'ansible',
  \ }
