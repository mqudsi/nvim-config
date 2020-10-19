" Vim syntax file
" Language: Visual Studio solution and project files
" Maintainer: Mahmoud Al-Qudsi, NeoSmart Technologies https://neosmart.net/

if exists("b:current_syntax")
	finish
endif

" Keywords
" syn match "[A-Z][a-zA-Z]+(\"[^)\"]\+\")
syn keyword syntaxElementKeyword VisualStudioVersion MinimumVisualStudioVersion
syn keyword syntaxElementKeyword Project EndProject
syn keyword syntaxElementKeyword Global EndGlobal
syn keyword syntaxElementKeyword GlobalSection EndGlobalSection
syn keyword syntaxElementKeyword ProjectSection EndProjectSection
syn keyword syntaxElementKeyword HideSolutionNode SolutionGuid

syn region vsSpecifier start="(" end=")" contains=variable,String
syn region String start='"' end='"' contains=guid

syn match vsOperator "|"
syn match vsDeclaration "Microsoft Visual Studio Solution File, Format Version .*"
syn match vsComment "#.*$"
" syn match String "\"[^\"]*\""
syn match guid "{[A-Fa-f0-9-]\+}"

let b:current_syntax = "vssln"
hi def link vsDeclaration SpecialComment
hi def link vsComment Comment
hi def link syntaxElementKeyword Keyword
hi def link guid Identifier
hi def link vsSpecifier Keyword
hi def link vsOperator Function
