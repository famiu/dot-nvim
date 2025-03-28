vim.cmd.highlight('clear')

local palette = {
    Black = '#0D0C11',
    Charcoal = '#16151A',
    MidnightBlue = '#0A1039',
    Gunmetal = '#353439',
    StoneGray = '#55545A',
    AshGray = '#96959C',
    LightSilver = '#BAB9C0',
    SkyBlue = '#C2D2FF',
    BlushPink = '#FFC7D9',
    IceBlue = '#A7E6FF',
    LavenderBlush = '#F3CEFF',
    MintGreen = '#C6EBB6',
    AquaMint = '#A2F0E1',
    PearlGray = '#DEDDE4',
    SandBeige = '#F2DDA1',
    Ivory = '#E6E1CF',
    CoralPeach = '#FFCCB1',
    DarkCrimson = '#300014',
    ForestTeal = '#00453C',
    BurntOchre = '#3F3100',
    DeepOlive = '#0F2901',
    Mahogany = '#400C0B',
}

local highlights = {
    -- Normal
    Normal = { bg = palette.Charcoal, fg = palette.PearlGray },
    NormalFloat = { bg = palette.Black, fg = palette.PearlGray },
    NormalNC = { link = 'Normal' },

    -- UI
    Added = { fg = palette.MintGreen },
    Changed = { fg = palette.AquaMint },
    ColorColumn = { bg = palette.StoneGray },
    Conceal = { fg = palette.IceBlue },
    CurSearch = { bg = palette.SandBeige, fg = palette.Charcoal },
    Cursor = { bg = palette.PearlGray, fg = palette.Charcoal },
    CursorColumn = { bg = palette.Gunmetal },
    CursorLine = { bg = palette.Gunmetal },
    CursorLineFold = { fg = palette.StoneGray },
    CursorLineNr = { bold = true, fg = palette.SkyBlue },
    CursorLineSign = { fg = palette.StoneGray },
    DiffAdd = { bg = palette.DeepOlive },
    DiffChange = { bg = palette.ForestTeal },
    DiffDelete = { bg = palette.Mahogany },
    DiffText = { bg = palette.BurntOchre },
    Directory = { fg = palette.IceBlue },
    EndOfBuffer = { fg = palette.StoneGray },
    ErrorMsg = { fg = palette.BlushPink },
    FloatBorder = { bg = palette.Black, fg = palette.SkyBlue },
    FloatTitle = { bg = palette.Black, bold = true, fg = palette.SkyBlue },
    FoldColumn = { fg = palette.StoneGray },
    Folded = { bg = palette.Black, fg = palette.AshGray },
    IncSearch = { bg = palette.SandBeige, fg = palette.Charcoal },
    LineNr = { fg = palette.StoneGray },
    MatchParen = { bg = palette.StoneGray, bold = true },
    ModeMsg = { fg = palette.MintGreen },
    MoreMsg = { fg = palette.IceBlue },
    MsgArea = { link = 'Normal' },
    MsgSeparator = { bg = palette.StoneGray, fg = palette.AshGray },
    NonText = { fg = palette.StoneGray },
    Pmenu = { bg = palette.Gunmetal, fg = palette.PearlGray },
    PmenuKind = { bg = palette.Gunmetal, fg = palette.IceBlue },
    PmenuMatch = { bg = palette.Gunmetal, bold = true, fg = palette.PearlGray },
    PmenuMatchSel = { blend = 0, bold = true, reverse = true },
    PmenuThumb = { bg = palette.StoneGray },
    Question = { fg = palette.IceBlue },
    QuickFixLine = { bold = true },
    Removed = { fg = palette.BlushPink },
    Search = { bg = palette.SkyBlue, fg = palette.Charcoal },
    SignColumn = { fg = palette.StoneGray },
    SpecialKey = { fg = palette.StoneGray },
    SpellBad = { sp = palette.BlushPink, undercurl = true },
    SpellCap = { sp = palette.AquaMint, undercurl = true },
    SpellLocal = { sp = palette.SandBeige, undercurl = true },
    SpellRare = { sp = palette.SkyBlue, undercurl = true },
    StatusLine = { bg = palette.Black, fg = palette.LightSilver },
    StatusLineNC = { bg = palette.Gunmetal, fg = palette.LightSilver },
    Substitute = { bg = palette.SkyBlue, fg = palette.Charcoal },
    TabLine = { bg = palette.Black, fg = palette.LightSilver },
    TabLineSel = { bg = palette.Black, fg = palette.SkyBlue },
    TermCursorNC = { reverse = true },
    Title = { fg = palette.SkyBlue },
    VertSplit = { fg = palette.SkyBlue },
    Visual = { bg = palette.StoneGray },
    VisualNOS = { bg = palette.Gunmetal },
    WarningMsg = { fg = palette.SandBeige },
    Whitespace = { fg = palette.StoneGray },
    WinBar = { link = 'StatusLine' },
    WinBarNC = { link = 'StatusLineNC' },
    WinSeparator = { fg = palette.SkyBlue },
    lCursor = { bg = palette.PearlGray, fg = palette.Charcoal },

    -- Syntax
    Comment = { fg = palette.AshGray },
    Constant = { fg = palette.LavenderBlush },
    Delimiter = { fg = palette.CoralPeach },
    Error = { bg = palette.DarkCrimson },
    Float = { link = 'Constant' },
    Function = { fg = palette.IceBlue },
    Identifier = { fg = palette.Ivory },
    Ignore = { link = 'Normal' },
    Operator = { fg = palette.PearlGray },
    PreProc = { fg = palette.SkyBlue },
    Special = { fg = palette.AquaMint },
    Statement = { bold = true, fg = palette.PearlGray },
    String = { fg = palette.MintGreen },
    Todo = { bg = palette.MidnightBlue, bold = true, fg = palette.SkyBlue },
    Type = { fg = palette.SandBeige },

    -- Diagnostic
    DiagnosticDeprecated = { sp = palette.BlushPink, strikethrough = true },
    DiagnosticError = { fg = palette.BlushPink },
    DiagnosticFloatingError = { bg = palette.Black, fg = palette.BlushPink },
    DiagnosticFloatingHint = { bg = palette.Black, fg = palette.AquaMint },
    DiagnosticFloatingInfo = { bg = palette.Black, fg = palette.SkyBlue },
    DiagnosticFloatingOk = { bg = palette.Black, fg = palette.MintGreen },
    DiagnosticFloatingWarn = { bg = palette.Black, fg = palette.SandBeige },
    DiagnosticHint = { fg = palette.AquaMint },
    DiagnosticInfo = { fg = palette.SkyBlue },
    DiagnosticOk = { fg = palette.MintGreen },
    DiagnosticUnderlineError = { sp = palette.BlushPink, underline = true },
    DiagnosticUnderlineHint = { sp = palette.AquaMint, underline = true },
    DiagnosticUnderlineInfo = { sp = palette.SkyBlue, underline = true },
    DiagnosticUnderlineOk = { sp = palette.MintGreen, underline = true },
    DiagnosticUnderlineWarn = { sp = palette.SandBeige, underline = true },
    DiagnosticWarn = { fg = palette.SandBeige },

    -- Built-in LSP
    LspCodeLens = { link = 'Comment' },
    LspCodeLensSeparator = { link = 'Comment' },
    LspReferenceText = { bg = palette.StoneGray },
    LspSignatureActiveParameter = { link = 'LspReferenceText' },

    -- Treesitter standard groups
    ['@character.special'] = { link = 'SpecialChar' },
    ['@comment.documentation'] = { link = '@comment' },
    ['@comment.error'] = { link = '@text.danger' },
    ['@comment.note'] = { link = '@text.note' },
    ['@comment.todo'] = { link = '@text.todo' },
    ['@comment.warning'] = { link = '@text.warning' },
    ['@conditional'] = { link = 'Conditional' },
    ['@constant.builtin'] = { link = 'Special' },
    ['@constant.macro'] = { link = 'Macro' },
    ['@debug'] = { link = 'Debug' },
    ['@define'] = { link = 'Define' },
    ['@diff.delta'] = { link = 'diffChanged' },
    ['@diff.minus'] = { link = 'diffRemoved' },
    ['@diff.plus'] = { link = 'diffAdded' },
    ['@exception'] = { link = 'Exception' },
    ['@field'] = { link = 'Identifier' },
    ['@float'] = { link = 'Float' },
    ['@function.builtin'] = { link = 'Special' },
    ['@function.call'] = { link = 'Function' },
    ['@function.macro'] = { link = 'Macro' },
    ['@function.method'] = { link = '@method' },
    ['@function.method.call'] = { link = '@method.call' },
    ['@include'] = { link = 'Include' },
    ['@keyword.conditional'] = { link = '@keyword' },
    ['@keyword.conditional.ternary'] = { link = 'Keyword' },
    ['@keyword.coroutine'] = { link = '@keyword' },
    ['@keyword.debug'] = { bold = true, fg = palette.AquaMint },
    ['@keyword.directive'] = { bold = true, fg = palette.SkyBlue },
    ['@keyword.directive.define'] = { link = '@keyword.directive' },
    ['@keyword.exception'] = { link = '@keyword' },
    ['@keyword.function'] = { link = '@keyword' },
    ['@keyword.import'] = { bold = true, fg = palette.SkyBlue },
    ['@keyword.operator'] = { link = '@keyword' },
    ['@keyword.repeat'] = { link = '@keyword' },
    ['@keyword.return'] = { bold = true, fg = palette.CoralPeach },
    ['@keyword.storage'] = { bold = true, fg = palette.PearlGray },
    ['@keyword.type'] = { link = '@keyword' },
    ['@macro'] = { link = 'Macro' },
    ['@markup.environment'] = { link = '@module' },
    ['@markup.heading'] = { link = '@text.title' },
    ['@markup.italic'] = { link = '@text.emphasis' },
    ['@markup.link'] = { link = '@text.reference' },
    ['@markup.link.label'] = { link = '@markup.link' },
    ['@markup.link.url'] = { fg = palette.PearlGray, underline = true },
    ['@markup.list'] = { link = '@punctuation.special' },
    ['@markup.list.checked'] = { link = 'DiagnosticOk' },
    ['@markup.list.unchecked'] = { link = 'DiagnosticWarn' },
    ['@markup.math'] = { link = '@string.special' },
    ['@markup.quote'] = { link = '@string.special' },
    ['@markup.raw'] = { link = '@text.literal' },
    ['@markup.raw.block'] = { link = '@markup.raw' },
    ['@markup.strikethrough'] = { link = '@text.strike' },
    ['@markup.strong'] = { link = '@text.strong' },
    ['@markup.underline'] = { link = '@text.underline' },
    ['@method'] = { link = 'Function' },
    ['@method.call'] = { link = 'Function' },
    ['@module'] = { link = '@namespace' },
    ['@module.builtin'] = { link = '@variable.builtin' },
    ['@namespace'] = { link = 'Identifier' },
    ['@none'] = { link = 'Normal' },
    ['@number.float'] = { link = '@float' },
    ['@parameter'] = { fg = palette.SkyBlue },
    ['@preproc'] = { link = 'PreProc' },
    ['@punctuation.bracket'] = { link = '@punctuation' },
    ['@punctuation.delimiter'] = { link = '@punctuation' },
    ['@punctuation.special'] = { link = 'Special' },
    ['@repeat'] = { link = 'Repeat' },
    ['@storageclass'] = { link = 'StorageClass' },
    ['@string.documentation'] = { link = '@string' },
    ['@string.escape'] = { link = 'SpecialChar' },
    ['@string.regexp'] = { link = 'SpecialChar' },
    ['@string.special'] = { link = 'SpecialChar' },
    ['@string.special.path'] = { link = 'Directory' },
    ['@string.special.symbol'] = { link = '@constant' },
    ['@string.special.url'] = { link = '@markup.link.url' },
    ['@string.special.vimdoc'] = { link = '@constant' },
    ['@structure'] = { link = 'Structure' },
    ['@symbol'] = { link = 'Keyword' },
    ['@tag.attribute'] = { link = '@tag' },
    ['@tag.delimiter'] = { link = '@punctuation' },
    ['@text.danger'] = { link = 'ErrorMsg' },
    ['@text.emphasis'] = { italic = true },
    ['@text.literal'] = { link = 'Special' },
    ['@text.note'] = { link = 'MoreMsg' },
    ['@text.reference'] = { link = 'Identifier' },
    ['@text.strike'] = { strikethrough = true },
    ['@text.strong'] = { bold = true },
    ['@text.title'] = { link = 'Title' },
    ['@text.todo'] = { link = 'Todo' },
    ['@text.underline'] = { link = 'Underlined' },
    ['@text.uri'] = { link = 'Underlined' },
    ['@text.warning'] = { link = 'WarningMsg' },
    ['@type.builtin'] = { link = 'Special' },
    ['@type.definition'] = { link = 'Typedef' },
    ['@type.qualifier'] = { link = 'StorageClass' },
    ['@variable'] = { fg = palette.PearlGray },
    ['@variable.builtin'] = { link = 'Special' },
    ['@variable.member'] = { link = '@field' },
    ['@variable.parameter'] = { link = '@parameter' },

    -- LSP Semantic Tokens
    ['@lsp.mod.defaultLibrary'] = { link = 'Special' },
    ['@lsp.mod.deprecated'] = { fg = palette.BlushPink },
    ['@lsp.type.class'] = { link = '@structure' },
    ['@lsp.type.decorator'] = { link = '@function' },
    ['@lsp.type.enum'] = { link = '@type' },
    ['@lsp.type.enumMember'] = { link = '@constant' },
    ['@lsp.type.function'] = { link = '@function' },
    ['@lsp.type.interface'] = { link = '@type' },
    ['@lsp.type.macro'] = { link = '@macro' },
    ['@lsp.type.method'] = { link = '@method' },
    ['@lsp.type.namespace'] = { link = '@namespace' },
    ['@lsp.type.parameter'] = { link = '@parameter' },
    ['@lsp.type.property'] = { link = '@property' },
    ['@lsp.type.struct'] = { link = '@structure' },
    ['@lsp.type.type'] = { link = '@type' },
    ['@lsp.type.typeParameter'] = { link = '@type.definition' },
    ['@lsp.type.variable'] = { link = '@variable' },
}

local set_hl = vim.api.nvim_set_hl

for hl_name, hl_info in pairs(highlights) do
    set_hl(0, hl_name, hl_info)
end

vim.g.colors_name = 'lullaby'
