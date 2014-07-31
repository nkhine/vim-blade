" Vim syntax file
" Language: Jade
" Maintainer: Norman Khine
" Credits: Tim Pope
" Filenames: *.blade

if exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'blade'
endif

silent! syntax include @htmlCoffeescript syntax/coffee.vim
unlet! b:current_syntax
silent! syntax include @htmlStylus syntax/stylus.vim
unlet! b:current_syntax
silent! syntax include @htmlMarkdown syntax/markdown.vim
unlet! b:current_syntax

syn case match

syn region  javascriptParenthesisBlock start="(" end=")" contains=@htmlJavascript contained keepend
syn cluster htmlJavascript add=javascriptParenthesisBlock

syn region  bladeJavascript matchgroup=bladeJavascriptOutputChar start="[!&]\==\|\~" skip=",\s*$" end="$" contained contains=@htmlJavascript keepend
syn region  bladeJavascript matchgroup=bladeJavascriptChar start="-" skip=",\s*$" end="$" contained contains=@htmlJavascript keepend
syn cluster bladeTop contains=bladeBegin,bladeComment,bladeHtmlComment,bladeJavascript
syn match   bladeBegin "^\s*\%([<>]\|&[^=~ ]\)\@!" nextgroup=bladeTag,bladeClassChar,bladeIdChar,bladePlainChar,bladeJavascript,bladeScriptConditional,bladeScriptStatement,bladePipedText
syn match   bladeTag "+\?\w\+\%(:\w\+\)\=" contained contains=htmlTagName,htmlSpecialTagName nextgroup=@bladeComponent
syn cluster bladeComponent contains=bladeAttributes,bladeIdChar,bladeBlockExpansionChar,bladeClassChar,bladePlainChar,bladeJavascript,bladeTagBlockChar,bladeTagInlineText
syn match   bladeComment '\s*\/\/.*$'
syn region  bladeHtmlConditionalComment start="<!--\%(.*\)>" end="<!\%(.*\)-->"
syn region  bladeAttributes matchgroup=bladeAttributesDelimiter start="(" end=")" contained contains=@htmlJavascript,bladeHtmlArg,htmlArg,htmlEvent,htmlCssDefinition nextgroup=@bladeComponent
syn match   bladeClassChar "\." contained nextgroup=bladeClass
syn match   bladeBlockExpansionChar ":\s\+" contained nextgroup=bladeTag
syn match   bladeIdChar "#[[{]\@!" contained nextgroup=bladeId
syn match   bladeClass "\%(\w\|-\)\+" contained nextgroup=@bladeComponent
syn match   bladeId "\%(\w\|-\)\+" contained nextgroup=@bladeComponent
syn region  bladeDocType start="^\s*\(!!!\|doctype\)" end="$"
" Unless I'm mistaken, syntax/html.vim requires
" that the = sign be present for these matches.
" This adds the matches back for blade.
syn keyword bladeHtmlArg contained href title

syn match   bladePlainChar "\\" contained
syn region  bladeInterpolation matchgroup=bladeInterpolationDelimiter start="#{" end="}" contains=@htmlJavascript
syn match   bladeInterpolationEscape "\\\@<!\%(\\\\\)*\\\%(\\\ze#{\|#\ze{\)"
syn match   bladeTagInlineText "\s.*$" contained contains=bladeInterpolation,bladeTextInlineJade
syn region  bladePipedText matchgroup=bladePipeChar start="|" end="$" contained contains=bladeInterpolation,bladeTextInlineJade nextgroup=bladePipedText skipnl
syn match   bladeTagBlockChar "\.$" contained nextgroup=bladeTagBlockText,bladeTagBlockEnd skipnl
syn region  bladeTagBlockText start="\%(\s*\)\S" end="\ze\n" contained contains=bladeInterpolation,bladeTextInlineJade nextgroup=bladeTagBlockText,bladeTagBlockEnd skipnl
syn region  bladeTagBlockEnd start="\s*\S" end="$" contained contains=bladeInterpolation,bladeTextInlineJade nextgroup=bladeBegin skipnl
syn region  bladeTextInlineJade matchgroup=bladeInlineDelimiter start="#\[" end="]" contained contains=bladeTag keepend

syn region  bladeJavascriptFilter matchgroup=bladeFilter start="^\z(\s*\):javascript\s*$" end="^\%(\z1\s\|\s*$\)\@!" contains=@htmlJavascript
syn region  bladeCoffeescriptFilter matchgroup=bladeFilter start="^\z(\s*\):coffeescript\s*$" end="^\%(\z1\s\|\s*$\)\@!" contains=@htmlCoffeescript
syn region  bladeMarkdownFilter matchgroup=bladeFilter start=/^\z(\s*\):markdown\s*$/ end=/^\%(\z1\s\|\s*$\)\@!/ contains=@htmlMarkdown
syn region  bladeStylusFilter matchgroup=bladeFilter start="^\z(\s*\):stylus\s*$" end="^\%(\z1\s\|\s*$\)\@!" contains=@htmlStylus
syn region  bladePlainFilter matchgroup=bladeFilter start="^\z(\s*\):\%(sass\|less\|cdata\)\s*$" end="^\%(\z1\s\|\s*$\)\@!"

syn match  bladeScriptConditional "^\s*\<\%(if\|else\|unless\|while\|until\|case\|when\|default\)\>[?!]\@!"
syn match  bladeScriptStatement "^\s*\<\%(each\|for\|block\|prepend\|append\|mixin\|extends\|include\)\>[?!]\@!"
syn region  bladeScriptLoopRegion start="^\s*\(for \)" end="$" contains=bladeScriptLoopKeywords
syn keyword  bladeScriptLoopKeywords for in contained

syn region  bladeJavascript start="^\z(\s*\)script\%(:\w\+\)\=" end="^\%(\z1\s\|\s*$\)\@!" contains=@htmlJavascript,bladeJavascriptTag keepend 
syn region  bladeJavascriptTag contained start="^\z(\s*\)script\%(:\w\+\)\=" end="$" contains=bladeBegin,bladeTag
syn region  bladeCssBlock        start="^\z(\s*\)style" nextgroup=@bladeComponent,bladeError  end="^\%(\z1\s\|\s*$\)\@!" contains=@bladeTop,@htmlCss keepend

syn match  bladeError "\$" contained

hi def link bladePlainChar              Special
hi def link bladeScriptConditional      PreProc
hi def link bladeScriptLoopKeywords     PreProc
hi def link bladeScriptStatement        PreProc
hi def link bladeHtmlArg                htmlArg
hi def link bladeAttributeString        String
hi def link bladeAttributesDelimiter    Identifier
hi def link bladeIdChar                 Special
hi def link bladeClassChar              Special
hi def link bladeBlockExpansionChar     Special
hi def link bladePipeChar               Special
hi def link bladeTagBlockChar           Special
hi def link bladeId                     Identifier
hi def link bladeClass                  Type
hi def link bladeInterpolationDelimiter Delimiter
hi def link bladeInlineDelimiter        Delimiter
hi def link bladeFilter                 PreProc
hi def link bladeDocType                PreProc
hi def link bladeComment                Comment
hi def link bladeHtmlConditionalComment bladeComment

let b:current_syntax = "blade"

if main_syntax == "blade"
  unlet main_syntax
endif
