" Vim color file
" Maintainer:	Sébastien M-B <seb@essembeh.org>  
" Last Change:	Work in progress 
" URL:			none

" cool help screens
" :he group-name
" :he highlight-groups
" :he cterm-colors

set background=light
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="essembeh"

" hi Normal

" OR

" highlight clear Normal
" set background&
" highlight clear
" if &background == "light"
"   highlight Error ...
"   ...
" else
"   highlight Error ...
"   ...
" endif

" A good way to see what your colorscheme does is to follow this procedure:
" :w 
" :so % 
"
" Then to see what the current setting is use the highlight command.  
" For example,
" 	:hi Cursor
" gives
"	Cursor         xxx guifg=bg guibg=fg 
 	
" Uncomment and complete the commands you want to change from the default.

"hi Cursor		
"hi CursorIM	
"hi Directory	
"hi DiffAdd		
"hi DiffChange	
"hi DiffDelete	
"hi DiffText	
"hi ErrorMsg	
"hi VertSplit	
"hi Folded		
"hi FoldColumn	
"hi IncSearch	
"hi LineNr		
"hi ModeMsg		
"hi MoreMsg		
"hi NonText		
"hi Question	
hi Search ctermbg=4 ctermfg=7
"hi SpecialKey	
"hi StatusLine	
"hi StatusLineNC	
"hi Title		
hi Visual ctermbg=235
"hi VisualNOS	
"hi WarningMsg	
"hi WildMenu	
"hi Menu		
"hi Scrollbar	
"hi Tooltip		

" syntax highlighting groups
hi Comment ctermfg=240
"hi Constant	
"hi Identifier	
"hi Statement	
"hi PreProc	
"hi Type		
"hi Special	
"hi Underlined	
"hi Ignore		
"hi Error		
"hi Todo		

