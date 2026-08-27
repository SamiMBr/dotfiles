" configurations for editing yaml
autocmd FileType yaml,yaml.ansible setlocal indentkeys-=0# indentkeys-=<:>

"" Enable coc ansible on yaml.ansible and yaml filetypes extensions
let g:coc_filetype_map = {
  \ 'yaml.ansible': 'ansible',
  \ 'yaml': 'ansible',
  \ }

