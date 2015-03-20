" Vim syntax file
" Language:	actionScript
" Maintainer:   David Fishburn (dfishburn DOT vim AT gmail DOT com)
" Creator:	Abdul Qabiz <mail@abdulqabiz.com>
" 		Author and previous maintainer:
" 		Igor Dvorsky <amigo@modesite.net>
" URL:		http://www.abdulqabiz.com/files/vim/actionscript.vim
" Original URL: http://www.modesite.net/vim/actionscript.vim
" Last Change: 2010 May 05
" Version:     4.0
" Updated to support AS 2.0 2004 Mar 12 by Richard Leider  (richard@appliedrhetoric.com)
" Updated to support new AS 2.0 Flash 8 Language Elements 2005 September 29 (richard@appliedrhetoric.com)
" Updated to support new AS 3.0 Language Elements 2006 June 20 by Abdul Qabiz (mail at abdulqabiz.com)
" Updated to remove the check for embedded {} by Ingo Karkat.


" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
  finish
endif
  let main_syntax = 'actionscript'
endif

" based on "JavaScript" VIM syntax by Claudio Fleiner <claudio@fleiner.com>

syn case ignore

"" ActionScript comments
syn keyword actionScriptCommentTodo                     TODO FIXME XXX TBD contained
syn region  actionScriptLineComment                     start=+\/\/+ end=+$+ keepend contains=actionScriptCommentTodo,@Spell
syn region  actionScriptLineComment                     start=+^\s*\/\/+ skip=+\n\s*\/\/+ end=+$+ keepend contains=actionScriptCommentTodo,@Spell fold
syn match   actionScriptCommentSkip			"^[ \t]*\*\($\|[ \t]\+\)"
syn region  actionScriptCommentString			start=+"+  skip=+\\\\\|\\"+  end=+"+ end=+\*/+me=s-1,he=s-1 contains=actionScriptSpecial,actionScriptCommentSkip,@htmlPreproc
syn region  actionScriptComment2String			start=+"+  skip=+\\\\\|\\"+  end=+$\|"+  contains=actionScriptSpecial,@htmlPreproc
syn region  actionScriptCvsTag                          start="\$\cid:" end="\$" oneline contained
syn region  actionScriptComment				start="/\*"  end="\*/" contains=actionScriptCommentString,actionScriptCharacter,actionScriptNumber,actionScriptCvsTag,@Spell fold

" syn match   actionScriptSpecial                         "\\\d\d\d\|\\x\x\{2\}\|\\u\x\{4\}\|\\."
syn match   actionScriptSpecial				"\\\d\d\d\|\\."
syn region  actionScriptStringD				start=+"+  skip=+\\\\\|\\"+  end=+"+  contains=actionScriptSpecial,@htmlPreproc
syn region  actionScriptStringS				start=+'+  skip=+\\\\\|\\'+  end=+'+  contains=actionScriptSpecial,@htmlPreproc
syn region  actionScriptRegexpString                    start=+/\(\*\|/\)\@!+ skip=+\\\\\|\\/+ end=+/[gim]\{,3}+ contains=actionScriptSpecial,@htmlPreproc oneline
syn match   actionScriptNumber				"-\=\<\d\+L\=\>\|0[xX][0-9a-fA-F]\+\>"
syn match   actionScriptFloat                           /\<-\=\%(\d\+\.\d\+\|\d\+\.\|\.\d\+\)\%([eE][+-]\=\d\+\)\=\>/


syn match   actionScriptLabel                           /\(?\s*\)\@<!\<\w\+\(\s*:\)\@=/

syn match   actionScriptSpecialCharacter		"'\\.'"

syn match   actionScriptBraces				"([{}])"
"
"" Programm Keywords
syn keyword actionScriptSource                          import include
syn match   actionScriptUseNamespace                    "use namespace" 
syn keyword actionScriptVar                             const yield this var super
syn keyword actionScriptOperator			delete new in as instanceof typeof
syn keyword actionScriptBoolean			        true false
syn keyword actionScriptNull			        null undefined void NaN Infinity
syn keyword actionScriptConstant                        MAX_VALUE MIN_VALUE PI PHI

"" Statement Keywords
syn keyword actionScriptConditional			if else and or not
syn keyword actionScriptRepeat				do while for each
syn keyword actionScriptBranch  			break continue switch label case default return
syn keyword actionScriptStatement 			try catch finally throw with

syn keyword actionScriptGlobalObjects			int Array Boolean Number Class Object String Date Function Math Packages RegExp String

syn keyword actionScriptAttributes                      public final internal native override private static dynamic protected
syn keyword actionScriptDefinitions                     namespace extends interface implements package function class get set

syn keyword actionScriptExceptions                      Error EvalError RangeError ReferenceError SyntaxError TypeError URIError

syn keyword actionScriptFutureKeys                      abstract enum short boolean export byte long char native synchronized float throws goto transient debugger volatile double

if exists("b:actionscript_fold")
  syn match   actionScriptFunction       /\<function\>/ nextgroup=actionScriptFuncName skipwhite
  syn match   actionScriptOpAssign       /=\@<!=/ nextgroup=actionScriptFuncBlock skipwhite skipempty
  syn region  actionScriptFuncName       contained matchgroup=actionScriptFuncName start=/\%(\$\|\w\)*\s*(/ end=/)/ contains=actionScriptLineComment,actionScriptComment nextgroup=actionScriptFuncBlock skipwhite skipempty
  syn region  actionScriptFuncBlock      contained matchgroup=actionScriptFuncBlock start="{" end="}" contains=@actionScriptAll,actionScriptParensErrA,actionScriptParensErrB,actionScriptParen,actionScriptBracket,actionScriptBlock fold

    "" MRF 12/3/10 - fuck automatic folding
    " if &l:filetype=='javascript' && !&diff
    "   " Fold setting
    "   " Redefine the foldtext (to show a JS function outline) and foldlevel
    "   " only if the entire buffer is JavaScript, but not if JavaScript syntax
    "   " is embedded in another syntax (e.g. HTML).
    "   setlocal foldmethod=syntax
    "   setlocal foldlevel=4
    " endif
else
    syntax keyword actionScriptFunction       function
    setlocal foldmethod<
    setlocal foldlevel<
endif

"" Code blocks
syntax cluster actionScriptAll       contains=actionScriptComment,actionScriptLineComment,actionScriptDocComment,actionScriptStringD,actionScriptStringS,actionScriptRegexpString,actionScriptNumber,actionScriptFloat,actionScriptLabel,actionScriptFunction,actionScriptConditional,actionScriptUseNamespace,actionScriptAttributes,actionScriptDefinitions,actionScriptSource,actionScriptVar,actionScriptOperator,actionScriptBoolean,actionScriptNull,actionScriptRepeat,actionScriptBranch,actionScriptStatement,actionScriptGlobalObjects,actionScriptExceptions,actionScriptFutureKeys
syntax region  actionScriptBracket   matchgroup=actionScriptBracket transparent start="\[" end="\]" contains=@actionScriptAll,actionScriptParensErrB,actionScriptParensErrC,actionScriptBracket,actionScriptParen,actionScriptBlock,@htmlPreproc
syntax region  actionScriptParen     matchgroup=actionScriptParen   transparent start="("  end=")"  contains=@actionScriptAll,actionScriptParensErrA,actionScriptParensErrC,actionScriptParen,actionScriptBracket,actionScriptBlock,@htmlPreproc
syntax region  actionScriptBlock     matchgroup=actionScriptBlock   transparent start="{"  end="}"  contains=@actionScriptAll,actionScriptParensErrA,actionScriptParensErrB,actionScriptParen,actionScriptBracket,actionScriptBlock,@htmlPreproc 

"
"" JSDoc support start
if !exists("actionscript_ignore_actionScriptdoc")
  syntax case ignore

  "" syntax coloring for asdoc comments (HTML)
  "syntax include @javaHtml <sfile>:p:h/html.vim
  "unlet b:current_syntax

  syntax region actionScriptDocComment    matchgroup=actionScriptComment start="/\*\*\s*$"  end="\*/" contains=actionScriptDocTags,actionScriptCommentTodo,actionScriptCvsTag,@actionScriptHtml,@Spell fold
  syntax match  actionScriptDocTags       contained "@\(param\|argument\|requires\|exception\|throws\|type\|class\|extends\|see\|link\|member\|module\|method\|title\|namespace\|optional\|default\|base\|file\)\>" nextgroup=actionScriptDocParam,actionScriptDocSeeTag skipwhite
  syntax match  actionScriptDocTags       contained "@\(beta\|deprecated\|description\|fileoverview\|author\|license\|version\|returns\=\|constructor\|private\|protected\|final\|ignore\|addon\|exec\)\>"
  syntax match  actionScriptDocParam      contained "\%(#\|\w\|\.\|:\|\/\)\+"
  syntax region actionScriptDocSeeTag     contained matchgroup=actionScriptDocSeeTag start="{" end="}" contains=actionScriptDocTags

  syntax case match
endif   "" JSDoc end



" catch errors caused by wrong parenthesis
" v4.0
" syn match   actionScriptInParen     contained "[{}]"
" syn region  actionScriptParen       transparent start="(" end=")" contains=actionScriptParen,actionScript.*
" syn match   actionScrParenError  ")"
syntax match   actionScriptParensError    ")\|}\|\]"
syntax match   actionScriptParensErrA     contained "\]"
syntax match   actionScriptParensErrB     contained ")"
syntax match   actionScriptParensErrC     contained "}"

if main_syntax == "actionscript"
  syn sync clear
  syn sync ccomment actionScriptLineComment
  " syn sync ccomment actionScriptComment
  syn sync match actionScriptHighlight grouphere actionScriptBlock /{/
endif

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_actionscript_syn_inits")
  if version < 508
    let did_actionscript_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink actionScriptComment              Comment
  HiLink actionScriptLineComment          Comment
  HiLink actionScriptDocComment           Comment
  HiLink actionScriptCommentTodo          Todo
  HiLink actionScriptCvsTag               Function
  HiLink actionScriptDocTags              Special
  HiLink actionScriptDocSeeTag            Function
  HiLink actionScriptDocParam             Function
  HiLink actionScriptStringS              String
  HiLink actionScriptStringD              String
  HiLink actionScriptRegexpString         String
  HiLink actionScriptCharacter            Character
  HiLink actionScriptPrototype            Type
  HiLink actionScriptConditional          Conditional
  HiLink actionScriptBranch               Conditional
  HiLink actionScriptRepeat               Repeat
  HiLink actionScriptStatement            Statement
  HiLink actionScriptFunction             Keyword " Function
  HiLink actionScriptError                Error
  HiLink actionScriptParensError          Error
  HiLink actionScriptParensErrA           Error
  HiLink actionScriptParensErrB           Error
  HiLink actionScriptParensErrC           Error
  HiLink actionScriptOperator             Operator
  HiLink actionScriptVar                  Keyword

  HiLink actionScriptNull                 Constant
  HiLink actionScriptConstant             Constant
  HiLink actionScriptNumber               Number
  HiLink actionScriptFloat                Number
  HiLink actionScriptBoolean              Boolean
  HiLink actionScriptLabel                Label
  " HiLink actionScriptIdentifier           Identifier
  HiLink actionScriptSpecial              Special
  HiLink actionScriptSource               Keyword
  HiLink actionScriptUseNamespace         Keyword
  HiLink actionScriptGlobalObjects        Type
  HiLink actionScriptExceptions           Special

  HiLink actionScriptAttributes           Keyword
  HiLink actionScriptDefinitions          Keyword
  delcommand HiLink
endif

let b:current_syntax = "actionscript"
if main_syntax == 'actionscript'
  unlet main_syntax
endif

" vim: ts=8

