if !exists('optional')
  let optional = []
endif
let optional += ["as3_omnicomplete","flex_dev","vim-fuzzyfinder","vim-l9","tagbar","slimv"]
call optional#include(optional)

" load tag and buffertag plugins
let g:ctrlp_extensions = ['tag', 'buffertag', 'line']

" let g:ctrlp_buftag_types = { 'javascript': '--language-force=javascript --javascript-types=fcmv' }
let g:ctrlp_buftag_types = { 
  \ 'actionscript': '--language-force=actionscript --actionscript-types=fpvcim'
  \ }

let g:ctrlp_open_multiple_files = '2vjr'

" since we're already re-binding ctrlp to <leader>t in common-vimrc
" let's unbind the default mapping
let g:ctrlp_map = ''

" i like .project and .actionScriptProperties files, but not all deez
let g:vim_ignore += ["bin-debug", "bin-release", "bin-release-temp", "\\.git"]

let g:ctrlp_show_hidden = 1

" let tcommentInlineAS3 = {
"                 \ 'mode': 'I',
"                 \ 'commentstring': '/* %s */',
"                 \ 'rxbeg': '\*\+',
"                 \ 'rxend': '',
"                 \ 'rxmid': '',
"                 \ 'replacements': g:tcomment#replacements_c
"                 \ }
let tcommentInlineAS3 = {
                \ 'mode': 'I',
                \ 'commentstring': '/* %s */',
                \ 'rxbeg': '\*\+',
                \ 'rxend': '',
                \ 'rxmid': '',
                \ 'replacements': g:tcomment#replacements_c
                \ }

let tcommentBlockAS3 = {
                \ 'commentstring': '/*%s */',
                \ 'middle': ' * ',
                \ 'rxbeg': '\*\+',
                \ 'rxend': '',
                \ 'rxmid': '',
                \ 'replacements': g:tcomment#replacements_c
                \ }

call tcomment#DefineType('actionscript',                  '// %s'             )
call tcomment#DefineType('actionscript_block',            g:tcommentBlockAS3             )
call tcomment#DefineType('actionscript_inline',           g:tcommentInlineAS3             )

	

" I liked it how it was
map <leader>e :FufFile<CR>
"
" this is already in common under
" map <leader>, :CtrlPBuffer<CR>

" haven't played around with this stuff yet.
map <leader>n :CtrlPBufTag<CR>
map <leader>N :CtrlPBufTagAll<CR> 
map <leader><C-t> :RegenTags<CR>:CtrlPClearAllCaches<CR>:silent! execute pathogen#helptags()<CR>

map <leader>b :TagbarToggle<CR>

noremap <leader>/ :TCommentMaybeInline<CR>
noremap <leader>? :TCommentBlock<CR> 

" tagbar
let g:tagbar_left = 1
" let g:tagbar_type_actionscript = {
"     \ 'kinds' : [
"         \ 'v:global variables:0:0',
"         \ 'c:classes',
"         \ 'm:methods',
"         \ 'p:properties',
"         \ 'f:functions',
"         \ 'x:mxtags:0:0',
"     \ ],
" \ }
" let g:tagbar_type_actionscript = {
"     \ 'ctagstype' : 'actionscript',
"     \ 'kinds'     : [
"         \ 'd:macros:1:0',
"         \ 'p:prototypes:1:0',
"         \ 'g:enums',
"         \ 'e:enumerators:0:0',
"         \ 't:typedefs:0:0',
"         \ 'n:namespaces',
"         \ 'c:classes',
"         \ 's:structs',
"         \ 'u:unions',
"         \ 'f:functions',
"         \ 'm:members:0:0',
"         \ 'v:variables:0:0'
"     \ ],
"     \ 'sro'        : '::',
"     \ 'kind2scope' : {
"         \ 'g' : 'enum',
"         \ 'n' : 'namespace',
"         \ 'c' : 'class',
"         \ 's' : 'struct',
"         \ 'u' : 'union'
"     \ },
"     \ 'scope2kind' : {
"         \ 'enum'      : 'g',
"         \ 'namespace' : 'n',
"         \ 'class'     : 'c',
"         \ 'struct'    : 's',
"         \ 'union'     : 'u'
"     \ }
" \ }


function! DillonRefreshIgnores() " {{{1
  if exists('g:vim_ignore')
    " if !exists('g:fuzzy_ignore')
      let g:fuzzy_ignore=join(map(copy(g:vim_ignore), 'v:val . "/**"'), ",")
    " endif

    " if !exists('g:ctrlp_custom_ignore')
      let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/](' . join(map(copy(g:vim_ignore), 'v:val'), "|") . ')$',
            \ 'file': '\v\.(exe|so|dll|orig|DS_Store)$'
            \ }
    " endif

    " if !exists('g:ack_ignore')
      let g:ack_ignore=copy(g:vim_ignore)
    " endif
  endif
endfunction " }}}1

call DillonRefreshIgnores()
    
