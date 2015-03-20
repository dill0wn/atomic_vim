" echo "dillon-vimrc.vim"

" i like .project and .actionScriptProperties files, but not all deez
let g:vim_ignore += ["bin-debug", "bin-release", "bin-release-temp", ".git", '.*.ipa'] 

if !exists("optional")
  let optional = []

  command -nargs=1 Opt let optional += [<args>]

  Opt "as3_omnicomplete"
  Opt "flex_dev"
  Opt "vim-fuzzyfinder"
  Opt "vim-l9"
  Opt "tagbar"
  Opt "slimv"
  Opt "syntastic"
  Opt "taghighlight"
  " Opt "townk-vim-autoclose-4dfe50" 
  Opt "delimitMate"

  call optional#include(optional) 
  delcommand Opt
endif

set autoread

" syntastic
" let g:syntastic_check_on_open = 0
" let g:syntastic_debug = 1+2+4+8+16+32
let g:syntastic_debug = 2
" syntastic actionscript
let g:syntastic_mode_map = { "mode" : "passive" }
let g:syntastic_actionscript_checkers = ["mxmlc"]
let g:syntastic_actionscript_mxmlc_exec = 'java'
let g:syntastic_actionscript_mxmlc_args = '-jar /Applications/Adobe\ Flash\ Builder\ 4.7/eclipse/plugins/com.adobe.flash.compiler_4.7.0.349722/AIRSDK/lib/mxmlc-cli.jar +flexlib=/Applications/Adobe\ Flash\ Builder\ 4.7/eclipse/plugins/com.adobe.flash.compiler_4.7.0.349722/AIRSDK/frameworks +configname=air'


" call air#setup($HOME.'/GitHub/PuzzleTD/', 'ppptd_ios')


let g:custom_ctag_options = {
      \ 'gametheater': '--language-force=gametheater',
      \ 'actionscript': '--language-force=actionscript',
      \ 'gtactionscript': '--language-force=actionscript',
      \ 'flex': '--language-force=flex'
      \ } 

" since we're already re-binding ctrlp to <leader>t in common-vimrc
" let's unbind the default mapping
let g:ctrlp_map = ''
let g:ctrlp_extensions = ['tag', 'buffertag', 'line'] 
let g:ctrlp_show_hidden = 1
let g:ctrlp_open_multiple_files = '2vjr' 
" let g:ctrlp_working_path_mode = 'war'

let g:ctrlp_buftag_types = { 
  \ 'actionscript': g:custom_ctag_options.actionscript
  \ } 

if exists("g:tag_options_override")
  for [next_key, next_val] in items(g:tag_options_override)
    if has_key(g:custom_ctag_options, next_val)
      let g:tag_options = g:custom_ctag_options[next_val]
      let g:ctrlp_buftag_types[next_key] = g:custom_ctag_options[next_val]
    endif
  endfor
endif

if version >= 508 || !exists("did_taghighlight_syn_inits")
  if version < 508
    let did_taghighlight_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink CTagsNamespace           Keyword " nope
  HiLink CTagsClass               Type
  HiLink CTagsInterface           Type
  HiLink CTagsDefinedName         Define
  HiLink CTagsType                Type
  HiLink CTagsMethod              Function
  HiLink CTagsFunction            Function 
  HiLink CTagsEnumerationValue    Keyword " nope
  HiLink CTagsEnumeratorName      Keyword  " nope
  HiLink CTagsConstant            Constant
  HiLink CTagsGlobalVariable      Identifier
  HiLink CTagsLocalVariable       Identifier
  HiLink CTagsVariable            Identifier
  HiLink CTagsUnion               Keyword " nope
  HiLink CTagsLabel               Label
  HiLink CTagsField               Identifier
  HiLink CTagsProperty            Function
  HiLink CTagsMember              Identifier
  HiLink CTagsMacro               Macro
  HiLink CTagsStructure           Keyword " nope

  HiLink CTagsSubroutine          Macro
  HiLink CTagsFragment            Keyword
  delcommand HiLink
endif


" autocmd FileType actionscript let g:tag_gen_options = g:ctrlp_buftag_types.actionscript 
" autocmd FileType actionscript map <leader><C-t> :RegenTags<CR>:CtrlPClearAllCaches<CR>

" \ 'actionscript': '--language-force=actionscript --actionscript-types=fpvcims'

" f - function
" p - props
" v - vars
" c - classes
" i - interfaces
" m - methods
" s - shouts
	

" :CtrlP
" :CtrlPTag
" :CtrlPLine
" :CtrlPBufTag
" :CtrlPBufTagAll
" :CtrlPUndo

inoremap jk <esc>
inoremap <esc> <nop>

" Move line or selection up/down one line
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" I liked it how it was
map <leader>e :FufFile<CR>

" haven't played around with this stuff yet.
map <leader>n :CtrlPBufTag<CR>
map <leader>N :CtrlPBufTagAll<CR> 
" map <leader><C-t> :RegenTags<CR>:CtrlPClearAllCaches<CR>:silent! execute pathogen#helptags()<CR>
map <leader><C-t> :UpdateTypesFile<CR>:CtrlPClearAllCaches<CR>:silent! execute pathogen#helptags()<CR>

map <leader>b :TagbarToggle<CR>

" window nav
map <leader>h :wincmd h<CR>
map <C-w>h <nop>
map <leader>j :wincmd j<CR>
map <C-w>j <nop>
map <leader>k :wincmd k<CR>
map <C-w>k <nop>
map <leader>l :wincmd l<CR>
map <C-w>l <nop>
map <leader><Tab> :wincmd p<CR>

map <leader>c :close<CR>
map <C-w>c <nop>

map <leader>/ :TComment<CR>
map <leader>? :TCommentBlock<CR>

augroup filetype_actionscript
  autocmd!
  autocmd FileType actionscript let maplocalleader = '-'
  autocmd FileType actionscript vmap <buffer> <leader>/ :TCommentMaybeInline<CR>
  autocmd FileType actionscript map <buffer> <leader>? :TCommentBlock<CR>
  autocmd FileType actionscript map <buffer> <localleader>c :SyntasticCheck<CR>


  autocmd FileType actionscript let b:delimitMate_expand_cr = 1
  autocmd FileType actionscript let b:delimitMate_jump_expansion = 1
  autocmd FileType actionscript let b:delimitMate_expand_space = 1
  autocmd FileType actionscript let b:delimitMate_backspace = 1
augroup END

" autocmd FileType ruby,eruby set omnifunc=rubycomplete ai sw=2 sts=2 et



function! DillonRefreshIgnores() " {{{1
  if exists('g:vim_ignore')
    " if !exists('g:fuzzy_ignore')
      let g:fuzzy_ignore=join(map(copy(g:vim_ignore), 'v:val . "/**"'), ",")
    " endif

    " if !exists('g:ctrlp_custom_ignore')
      let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/](' . join(map(copy(g:vim_ignore), 'v:val'), "|") . ')$',
            \ 'file': '\v\.(exe|so|dll|orig|DS_Store|swo|swp)$'
            \ }
    " endif

    " if !exists('g:ack_ignore')
      let g:ack_ignore=copy(g:vim_ignore)
    " endif
  endif
endfunction " }}}1

call DillonRefreshIgnores()
    



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
