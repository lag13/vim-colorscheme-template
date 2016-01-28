" A basic colorscheme created as a learning exercise in how colorschemes are
" made in vim as well as serving as a template if I want to create
" colorschemes in the future.

" "Short and Sweet": How syntax highlighting works.
"
" There are two pieces needed to make syntax highlighting happen.
"     - Syntax files
"     - Colorschemes
" Normally, people never have to worry about the first one, they just install
" the colorscheme they want and they're ready to go. However, both of these
" things are necessary to have syntax highlighting. You can view the syntax
" files that came with your vim distribution by looking at any of the files in
" the directory: $VIMRUNTIME/syntax. What those files essentially do is define
" regexes which correspond to parts of the language. These are things like
" keywords for the language (if, else, throw, etc...) or what strings and
" comments look like. We call those things syntax items. Syntax items will be
" stored in 'syntax groups' based on similarity. For example, keywords in a
" language will be stored in a common syntax group. A syntax group is then
" linked to a 'highlight group'. And that is all there is to a syntax file. It
" essentially labels all the language constructs and then says what
" highlighting group each of those labels should use.

" The colorscheme is conceptually very simple. All it does is define colors
" for the highlight groups. Once that is done all the syntax groups linked to
" those highlighting groups will have colors. Colorschemes can also change
" highlighting for specific languages if so desired. They just have to mess
" with the appropriate syntax group. For example solarized customizes how vim
" gets highlighted by having lines like this: hi! link vimVar Identifier. The
" one thing that really confuses me is that I can give highlighting to that
" syntax group vimVar and all syntax items inside the vimVar syntax group will
" get highlighted. Its almost as if syntax groups and highlight groups are
" actually the same thing? I'm not sure about the internals though.

" Initialize the colorscheme by removing all existing highlighting.
highlight clear
if exists("syntax_on")
    syntax reset
endif
" I don't believe this strictly needs to be here. I think it's only purpose is
" that when using the :colorscheme command with no arguments it outputs the
" value of this variable. I have seen only one practical use of it and that is
" to create a command which toggled between the light and dark flavors of a
" colorscheme. This is needed because to toggle you'll set 'background' to the
" opposite color and reload the colorscheme with: colorscheme {name}.
" g:colors_name provides the value for {name}.
let g:colors_name = "templatesolarized"

" Formats
let fmt_none = "NONE"
let fmt_bold = "NONE,bold"
let fmt_revr = "NONE,reverse"
let fmt_stnd = "NONE,standout"
let fmt_undb = "NONE,underline,bold"
let fmt_curl = "NONE,undercurl"
let fmt_undr = "NONE,underline"
let fmt_revu = "NONE,reverse,underline"

" Colors
let none = "NONE"
if has("gui_running")
    let s:vmode   = "gui"
    let base03  = "#1c1c1c"
    let base02  = "#262626"
    let base01  = "#4e4e4e"
    let base00  = "#585858"
    let base0   = "#808080"
    let base1   = "#8a8a8a"
    let base2   = "#d7d7af"
    let base3   = "#ffffd7"
    let yellow  = "#af8700"
    let orange  = "#d75f00"
    let red     = "#af0000"
    let magenta = "#af005f"
    let violet  = "#5f5faf"
    let blue    = "#0087ff"
    let cyan    = "#00afaf"
    let green   = "#5f8700"
elseif &t_Co == 256
    let s:vmode   = "cterm"
    let base03  = "234"
    let base02  = "235"
    let base01  = "239"
    let base00  = "240"
    let base0   = "244"
    let base1   = "245"
    let base2   = "187"
    let base3   = "230"
    let yellow  = "136"
    let orange  = "166"
    let red     = "124"
    let magenta = "125"
    let violet  = "61"
    let blue    = "33"
    let cyan    = "37"
    let green   = "64"
endif

" If you wanted to have a light and dark variation of a colorscheme then
" you'll probably want to add a check like this and define different colors if
" the condition holds:
if &background == "light"
    let temp03 = base03
    let temp02 = base02
    let temp01 = base01
    let temp00 = base00
    let base03 = base3
    let base02 = base2
    let base01 = base1
    let base00 = base0
    let base0  = temp00
    let base1  = temp01
    let base2  = temp02
    let base3  = temp03
endif

" In all honesty though, I have no idea what the 'background' option does
" exactly. The documentation for this option says:

"     When set to "dark", Vim will try to use colors that look good on a
"     dark background.  When set to "light", Vim will try to use colors that
"     look good on a light background.

" What the heck does that mean?? I really don't like the use of words like
" "try" when it relates to programming espeically when they don't follow it up
" with exactly what it is trying to do. Vim follows an algorithm goddammit! so
" what does setting 'background' actually do? Maybe I'm just missing
" something, but in my mind a colorscheme defines colors so why would changing
" an option alter them? For the cterm colors I specified a number. Does
" setting this option change what colors those numbers represent?

" Another thing I'm confused about is that if I set 'background' after vim has
" loaded the colors become different than the colorscheme regardless of what I
" set it to. I think this might be some funkiness with the terminal but I'm
" not completely sure.

" One last thing I'm confused about is that after running the :colorscheme
" {name} command, 'background' is set to light even if it was dark beforehand.

" Convenience function to reduce verbosity
function! s:highlight(highlight_group, format, foreground, background)
    execute 'highlight '.a:highlight_group.' '.s:vmode.'='.a:format.' '.s:vmode.'fg='.a:foreground.' '.s:vmode.'bg='.a:background
endfunction

" As far as I've seen a colorscheme does two things:
"
" - Highlights the text in the buffer. This is usually what I think of when I
"   think of syntax highlighting i.e highlighting keywords for various
"   languages.
" - Highlights features of the editor itself. These are things like the color
"   of the incremental search, what visual mode looks like, the column of line
"   numbers, etc...

" See :help group-name for the typical highlight groups which much be defined
" for the colorscheme to take effect. Examples are Comment and Type.

" See :help highlight-groups to see what highlight groups are used to change
" the highlighting of editor features. Examples are LineNr and Visual.

" Highlighting text in the buffer.
call s:highlight('Normal',     fmt_none, base0,   base03)
call s:highlight('Comment',    fmt_none, base01,  none)
call s:highlight('Constant',   fmt_none, cyan,    none)
call s:highlight('Identifier', fmt_none, blue,    none)
call s:highlight('Statement',  fmt_none, green,   none)
call s:highlight('PreProc',    fmt_none, orange,  none)
call s:highlight('Type',       fmt_none, yellow,  none)
call s:highlight('Special',    fmt_none, red,     none)
call s:highlight('Underlined', fmt_none, violet,  none)
call s:highlight('Ignore',     fmt_none, none,    none)
call s:highlight('Error',      fmt_bold, red,     none)
call s:highlight('Todo',       fmt_bold, magenta, none)
call s:highlight('SpecialKey', fmt_bold, base00,  base02)

" Highlighting features of the editor.
call s:highlight('NonText',      fmt_bold, base00, none)
call s:highlight('StatusLine',   fmt_revr, base1,  base02)
call s:highlight('StatusLineNC', fmt_revr, base00, base02)
call s:highlight('Visual',       fmt_revr, base01, base03)
call s:highlight('Directory',    fmt_none, blue,   none)
call s:highlight('ErrorMsg',     fmt_revr, red,    none)
call s:highlight('IncSearch',    fmt_stnd, orange, none)
call s:highlight('Search',       fmt_revr, yellow, none)
call s:highlight('MoreMsg',      fmt_none, blue,   none)
call s:highlight('ModeMsg',      fmt_none, blue,   none)
call s:highlight('LineNr',       fmt_none, base01, base02)
call s:highlight('Question',     fmt_bold, cyan,   none)
call s:highlight('VertSplit',    fmt_none, base00, base00)
call s:highlight('Title',        fmt_bold, orange, none)
call s:highlight('VisualNOS',    fmt_revr, none,   base02)
call s:highlight('WarningMsg',   fmt_bold, red,    none)
call s:highlight('WildMenu',     fmt_revr, base2,  base02)
call s:highlight('Folded',       fmt_undb, base0,  base02)
call s:highlight('FoldColumn',   fmt_none, base0,  base02)
call s:highlight('DiffAdd',      fmt_none, green,  base02)
call s:highlight('DiffChange',   fmt_none, yellow, base02)
call s:highlight('DiffDelete',   fmt_none, red,    base02)
call s:highlight('DiffText',     fmt_none, blue,   base02)
call s:highlight('SignColumn',   fmt_none, base0,  none)
call s:highlight('Conceal',      fmt_none, blue,   none)
call s:highlight('SpellBad',     fmt_curl, none,   none)
call s:highlight('SpellCap',     fmt_curl, none,   none)
call s:highlight('SpellRare',    fmt_curl, none,   none)
call s:highlight('SpellLocal',   fmt_curl, none,   none)
call s:highlight('Pmenu',        fmt_none, base0,  base02)
call s:highlight('PmenuSel',     fmt_revr, base01, base2)
call s:highlight('PmenuSbar',    fmt_none, base0,  base03)
call s:highlight('PmenuThumb',   fmt_none, base2,  base0)
call s:highlight('TabLine',      fmt_undr, base0,  base02)
call s:highlight('TabLineFill',  fmt_undr, base0,  base02)
call s:highlight('TabLineSel',   fmt_revu, base01, base2)
call s:highlight('CursorColumn', fmt_none, none,   base02)
call s:highlight('CursorLine',   fmt_none, none,   base02)
call s:highlight('ColorColumn',  fmt_none, none,   base02)
call s:highlight('Cursor',       fmt_none, red,    red)
call s:highlight('MatchParen',   fmt_bold, red,    base01)

