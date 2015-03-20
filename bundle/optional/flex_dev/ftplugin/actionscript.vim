" ActionScript filetype plugin file
" Language:    ActionScript (Flex development)
" Version:     1.0
" Maintainer:  David Fishburn <dfishburn at gmail dot com>
" Last Change: 2010 May 05

" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

" from as3_omnicomplete
if exists('&ofu')
  setlocal ofu=actionscriptcomplete#Complete
endif

let s:save_cpo = &cpo
set cpo=

" Disable autowrapping for code, but enable for comments
" t	Auto-wrap text using textwidth
" c     Auto-wrap comments using textwidth, inserting the current comment
"       leader automatically.
setlocal formatoptions-=t
setlocal formatoptions+=c

" Choose setting to be compatible with FlexBuilder (Eclipse)
set tabstop=4
set shiftwidth=4
set noexpandtab

" If the above runtime command succeeded, do not load the default settings
if exists("b:did_ftplugin")
  finish
endif

let b:undo_ftplugin = "setl comments<"

" Don't load another plugin for this buffer
let b:did_ftplugin     = 1
let b:current_ftplugin = 'actionscript'

" Mappings to move to the next BEGIN ... END block
" \W - no characters or digits
nmap <buffer> <silent> ]] :call search('\\c^\\s*{\\s*$', 'W' )<CR>
nmap <buffer> <silent> [[ :call search('\\c^\\s*{\\s*$', 'bW' )<CR>
nmap <buffer> <silent> ][ :call search('\\c^\\s*}\\s*$', 'W' )<CR>
nmap <buffer> <silent> [] :call search('\\c^\\s*}\\s*$', 'bW' )<CR>
vmap <buffer> <silent> ]] :<C-U>exec "normal! gv"<Bar>call search('\\c^\\s*{\\s*$', 'W' )<CR>
vmap <buffer> <silent> [[ :<C-U>exec "normal! gv"<Bar>call search('\\c^\\s*{\\s*$', 'bW' )<CR>
vmap <buffer> <silent> ][ :<C-U>exec "normal! gv"<Bar>call search('\\c^\\s*}\\s*$', 'W' )<CR>
vmap <buffer> <silent> [] :<C-U>exec "normal! gv"<Bar>call search('\\c^\\s*}\\s*$', 'bW' )<CR>

if exists("loaded_matchit")
    let b:match_ignorecase=0
    let b:match_words =
                \ &matchpairs .
                \ 
                \ ','.
                \ '\<if\>:'.
                \ '\<else\s\+if\>\|\<else\>,'.
                \ 
                \ '\<switch\>:'.
                \ '\<case\>\|\<break\>:'.
                \ '\<default\>,'.
                \
                \ '\%(\<do\>\|\<while\>\|\<for\>\):'.
                \ '\<break\>\|\<continue\>,'.
                \
                \ '\<try\>:'.
                \ '\<catch\>:'.
                \ '\<finally\>,'.
                \
                \  '<:>,' .
                \  '<\@<=!\[CDATA\[:]]>,'.
                \  '<\@<=!--:-->,'.
                \  '<\@<=?\k\+:?>,'.
                \  '<\@<=\([^ \t>/]\+\)\%(\s\+[^>]*\%([^/]>\|$\)\|>\|$\):<\@<=/\1>,'.
                \  '<\@<=\%([^ \t>/]\+\)\%(\s\+[^/>]*\|$\):/>'
endif


" Win32 can filter files in the browse dialog
if has("gui_win32") && !exists("b:browsefilter")
    let b:browsefilter = "ActionScript Files (*.as)\t*.as\n"
	  \ "MXML Files (*.mxml)\t*.mxml\n" .
	  \ "All Files (*.*)\t*.*\n"
endif

" Define how to find the macro definition of a variable using the various
" [d, [D, [_CTRL_D and so on features
" Match these values ignoring case
" ie  var name:String
let &l:define = '\<var\>'


" Comments can be of the form:
"   /*
"    *
"    */
" or
"   // 
setlocal comments=://,s1:/*,mb:*,ex:*/

" Enable gf on import statements.  Convert . in the import
" statement to / and append .as to the name, then search the path.
setlocal includeexpr=substitute(v:fname,'\\.','/','g')
setlocal suffixesadd=.as

" Functions to allow the user to change search
" path for MXML files.
" Mostly useful from autocmds.  This example below will work 
" with MXML and ActionScript files since they both define 
" a similar function.
"    autocmd bufread */PortalUI/*
"                \ let project_root = substitute(fnamemodify(expand("<afile>"), ':p:h'), 'PortalUI\zs.*', '', '')|
"                \ if exists("*AddSearchPath_".&ft) | call AddSearchPath_{&ft}(project_root.'/src') | endif
"
if !exists("*AddSearchPath_actionscript")
    " NOTE: You cannot use function! since this file can be 
    " sourced from within this function.  That will result in
    " an error reported by Vim.
    function AddSearchPath_actionscript(additional_path)
        " Path has this format 
        "    =.,.,C:\something,/opt/source
        " So check to see if the path has already been added
        if isdirectory(a:additional_path)
            if match(&path, '\(^\|,\)'.a:additional_path.'\($\|,\)') == -1
                let &l:path=(&l:path==''?'':',').a:additional_path
            endif
        endif
    endfunction
endif

" noremap <F5> :call JavaInsertImport()<CR>
" function! JavaInsertImport()
"   exe "normal mz"
"   let cur_class = expand("<cword>")
"   try
"     if search('^\s*import\s.*\.' . cur_class . '\s*;') > 0
"       throw getline('.') . ": import already exist!"
"     endif
"     wincmd }
"     wincmd P
"     1
"     if search('^\s*public.*\s\%(class\|interface\)\s\+' . cur_class) > 0
"       1
"       if search('^\s*package\s') > 0
"         yank y
"       else
"         throw "Package definition not found!"
"       endif
"     else
"       throw cur_class . ": class not found!"
"     endif
"     wincmd p
"     normal! G
"     " insert after last import or in first line
"     if search('^\s*import\s', 'b') > 0
"       put y
"     else
"       1
"       put! y
"     endif
"     substitute/^\s*package/import/g
"     substitute/\s\+/ /g
"     exe "normal! 2ER." . cur_class . ";\<Esc>lD"
"   catch /.*/
"     echoerr v:exception
"   finally
"     " wipe preview window (from buffer list)
"     silent! wincmd P
"     if &previewwindow
"       bwipeout
"     endif
"     exe "normal! `z"
"   endtry
" endfunction

let &cpo = s:save_cpo

" vim:sw=4:


