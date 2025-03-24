# OISHILINE

[NAME](#NAME)  
[SYNOPSIS](#SYNOPSIS)  
[DESCRIPTION](#DESCRIPTION)  
[DEFAULT SETUP CONFIGURATION](#DEFAULT%20SETUP%20CONFIGURATION)  
[DEFAULT MODULE CONFIGURATION](#DEFAULT%20MODULE%20CONFIGURATION)  
[tabline](#tabline)  
[branch](#branch)  
[diagnostics](#diagnostics)  
[encoding](#encoding)  
[filename](#filename)  
[format](#format)  
[location](#location)  
[mode](#mode)  
[progress](#progress)  
[separator](#separator)  
[type](#type)  
[SEE ALSO](#SEE%20ALSO)  
[AUTHOR](#AUTHOR)  

------------------------------------------------------------------------

## NAME <span id="NAME"></span>

oishiline − statusline and tabline for *nvim*(1).

## SYNOPSIS <span id="SYNOPSIS"></span>

**require("oishiline").setup()**

## DESCRIPTION <span id="DESCRIPTION"></span>

**oishiline** is a statusline and tabline for *nvim*(1).

## DEFAULT SETUP CONFIGURATION <span id="DEFAULT SETUP CONFIGURATION"></span>

{  
tabline = { enable = true },

globalArgs = {  
default = {  
fg = "#e5e9f0",  
bg = "#2e3440",  
ctermfg = 7,  
ctermbg = 0,  
},

colors = {  
black = "#2e3440",  
darkred = "#bf616a",  
darkgreen = "#a3be8c",  
darkyellow = "#ebcb8b",  
darkblue = "#81a1c1",  
darkmagenta = "#b48ead",  
darkcyan = "#88c0d0",  
lightgray = "#e5e9f0",  
darkgray = "#4c566a",  
red = "#bf616a",  
green = "#a3be8c",  
yellow = "#ebcb8b",  
blue = "#81a1c1",  
magenta = "#b48ead",  
cyan = "#88c0d0",  
white = "#8fbcbb",  
},  
},

statusline = {  
enable = true,

leftModules = {  
{ name = "mode" },  
{ name = "separator" },  
{ name = "branch" },  
{ name = "filename" },  
{ name = "diagnostics" },  
},

rightModules = {  
{  
name = "separator",

args = {  
suffix = "Right",

active = {  
gui = "",  
tty = "",  
},

inactive = {  
gui = "",  
tty = "",  
},

dataHl = {  
fg = "#4c566a",  
bg = "#2e3440",  
},

dataHlAlt = {  
fg = "#e5e9f0",  
bg = "#2e3440",  
},  
},  
},

{ name = "encoding" },  
{ name = "format" },  
{ name = "type" },

{  
name = "separator",

args = {  
suffix = "Right2",

active = {  
gui = "",  
tty = "",  
},

inactive = {  
gui = "",  
tty = "\|",  
},

dataHl = {  
fg = "#81a1c1",  
bg = "#4c566a",  
ctermfg = 4,  
ctermbg = 8,  
},

dataHlAlt = {  
fg = "#e5e9f0",  
ctermfg = 7,  
ctermbg = 8,  
},  
},  
},

{ name = "progress" },  
{ name = "location" },  
},  
},  
}

## DEFAULT MODULE CONFIGURATION <span id="DEFAULT MODULE CONFIGURATION"></span>

### tabline <span id="tabline"></span>

{  
suffix = "",

dataHl = {  
bg = "#81a1c1",  
bold = true,  
ctermbg = 4,  
ctermfg = 0,  
fg = "#2e3440",  
},

dataHlAlt = {  
bg = "#4c566a",  
ctermbg = 8,  
ctermfg = 7,  
fg = "#e5e9f0",  
},

iconHl = {  
bg = "#81a1c1",  
bold = true,  
ctermbg = 4,  
ctermfg = 0,  
fg = "#2e3440",  
},

iconHlAlt = {  
bg = "#4c566a",  
ctermbg = 8,  
ctermfg = 7,  
fg = "#e5e9f0",  
},

leftPad = {  
gui = " ",  
tty = " ",  
},

leftSep = {  
gui = "",  
tty = "",  
},

leftSepHl = {  
bg = "#81a1c1",  
ctermbg = 4,  
ctermfg = 0,  
fg = "#2e3440",  
},

leftSepHlAlt = {  
bg = "#4c566a",  
ctermbg = 8,  
ctermfg = 0,  
fg = "#2e3440",  
},

rightPad = {  
gui = " ",  
tty = " ",  
},

rightSep = {  
gui = "",  
tty = " ",  
},

rightSepHl = {  
bg = "#2e3440",  
ctermbg = 0,  
ctermfg = 4,  
fg = "#81a1c1",  
},

rightSepHlAlt = {  
bg = "#2e3440",  
ctermbg = 0,  
ctermfg = 8,  
fg = "#4c566a",  
},

start = {  
gui = "",  
tty = "",  
},  
}

### branch <span id="branch"></span>

{  
suffix = "",

dataHl = {  
bg = "#81a1c1",  
bold = true,  
ctermbg = 4,  
ctermfg = 0,  
fg = "#2e3440",  
},

dataHlAlt = {  
bg = "#4c566a",  
ctermbg = 8,  
ctermfg = 7,  
fg = "#e5e9f0",  
},

icon = {  
gui = " ",  
tty = "",  
},

iconHl = {  
bg = "#81a1c1",  
bold = true,  
ctermbg = 4,  
ctermfg = 0,  
fg = "#2e3440",  
},

iconHlAlt = {  
bg = "#4c566a",  
ctermbg = 8,  
ctermfg = 7,  
fg = "#e5e9f0",  
},

leftPad = {  
gui = " ",  
tty = " ",  
},

leftSep = {  
gui = "",  
tty = "",  
},

leftSepHl = {  
bg = "#81a1c1",  
bold = true,  
ctermbg = 4,  
ctermfg = 0,  
fg = "#2e3440",  
},

leftSepHlAlt = {  
bg = "#4c566a",  
ctermbg = 8,  
ctermfg = 0,  
fg = "#2e3440",  
},

rightPad = {  
gui = " ",  
tty = " ",  
},

rightSep = {  
gui = "",  
tty = "\|",  
},

rightSepHl = {  
bg = "#81a1c1",  
bold = true,  
ctermbg = 4,  
ctermfg = 0,  
fg = "#2e3440",  
},

rightSepHlAlt = {  
bg = "#4c566a",  
ctermbg = 8,  
ctermfg = 7,  
fg = "#e5e9f0",  
},  
}

### diagnostics <span id="diagnostics"></span>

{  
suffix = "",

sep = {  
gui = "",  
tty = "",  
},

Error = {  
bg = "#bf616a",  
ctermbg = 1,  
},

ErrorBg = {  
bg = "#bf616a",  
ctermbg = 1,  
},

Warn = {  
bg = "#ebcb8b",  
ctermbg = 3,  
},

WarnBg = {  
bg = "#ebcb8b",  
ctermbg = 3,  
},

Info = {  
bg = "#81a1c1",  
ctermbg = 4,  
},

InfoBg = {  
bg = "#81a1c1",  
ctermbg = 4,  
},

Hint = {  
bg = "#88c0d0",  
ctermbg = 6,  
},

HintBg = {  
bg = "#88c0d0",  
ctermbg = 6,  
},  
}

### encoding <span id="encoding"></span>

{  
suffix = "",

dataHl = {  
bg = "#4c566a",  
ctermbg = 8,  
ctermfg = 7,  
fg = "#e5e9f0",  
},

dataHlAlt = {  
bg = "#4c566a",  
ctermbg = 8,  
ctermfg = 7,  
fg = "#e5e9f0",  
},

icon = {  
gui = "",  
tty = "",  
},

iconHl = {  
bg = "#4c566a",  
ctermbg = 8,  
ctermfg = 7,  
fg = "#e5e9f0",  
},

iconHlAlt = {  
bg = "#4c566a",  
ctermbg = 8,  
ctermfg = 7,  
fg = "#e5e9f0",  
},

leftPad = {  
gui = " ",  
tty = " ",  
},

leftSep = {  
gui = "",  
tty = "",  
},

leftSepHl = {  
bg = "#2e3440",  
ctermbg = 0,  
ctermfg = 8,  
fg = "#4c566a",  
},

leftSepHlAlt = {  
bg = "#2e3440",  
ctermbg = 0,  
ctermfg = 8,  
fg = "#4c566a",  
},

rightPad = {  
gui = " ",  
tty = " ",  
},

rightSep = {  
gui = "",  
tty = "\|",  
},

rightSepHl = {  
bg = "#4c566a",  
ctermbg = 8,  
ctermfg = 7,  
fg = "#e5e9f0",  
},

rightSepHlAlt = {  
bg = "#4c566a",  
ctermbg = 8,  
ctermfg = 7,  
fg = "#e5e9f0",  
},  
}

### filename <span id="filename"></span>

{  
suffix = "",

dataHl = {  
bg = "#81a1c1",  
bold = true,  
ctermbg = 4,  
ctermfg = 0,  
fg = "#2e3440",  
},

dataHlAlt = {  
bg = "#4c566a",  
ctermbg = 8,  
ctermfg = 7,  
fg = "#e5e9f0",  
},

icon = {  
gui = "",  
tty = "",  
},

iconHl = {  
bg = "#81a1c1",  
bold = true,  
ctermbg = 4,  
ctermfg = 0,  
fg = "#2e3440",  
},

iconHlAlt = {  
bg = "#4c566a",  
ctermbg = 8,  
ctermfg = 7,  
fg = "#e5e9f0",  
},

leftPad = {  
gui = " ",  
tty = " ",  
},

leftSep = {  
gui = "",  
tty = "",  
},

leftSepHl = {  
bg = "#81a1c1",  
bold = true,  
ctermbg = 4,  
ctermfg = 0,  
fg = "#2e3440",  
},

leftSepHlAlt = {  
bg = "#e5e9f0",  
ctermbg = 7,  
ctermfg = 0,  
fg = "#2e3440",  
},

rightPad = {  
gui = " ",  
tty = " ",  
},

rightSep = {  
gui = "",  
tty = " ",  
},

rightSepHl = {  
bg = "#2e3440",  
ctermbg = 0,  
ctermfg = 1,  
fg = "#81a1c1",  
},

rightSepHlAlt = {  
bg = "#2e3440",  
ctermbg = 0,  
ctermfg = 8,  
fg = "#4c566a",  
},  
}

### format <span id="format"></span>

{  
suffix = "",

dataHl = {  
bg = "#4c566a",  
ctermbg = 8,  
ctermfg = 7,  
fg = "#e5e9f0",  
},

dataHlAlt = {  
bg = "#4c566a",  
ctermbg = 8,  
ctermfg = 7,  
fg = "#e5e9f0",  
},

icon = {  
gui = "",  
tty = "",  
},

iconHl = {  
bg = "#4c566a",  
ctermbg = 8,  
ctermfg = 7,  
fg = "#e5e9f0",  
},

iconHlAlt = {  
bg = "#4c566a",  
ctermbg = 8,  
ctermfg = 7,  
fg = "#e5e9f0",  
},

leftPad = {  
gui = " ",  
tty = " ",  
},

leftSep = {  
gui = "",  
tty = "",  
},

leftSepHl = {  
bg = "#4c566a",  
ctermbg = 8,  
ctermfg = 7,  
fg = "#e5e9f0",  
},

leftSepHlAlt = {  
bg = "#4c566a",  
ctermbg = 8,  
ctermfg = 7,  
fg = "#e5e9f0",  
},

rightPad = {  
gui = " ",  
tty = " ",  
},

rightSep = {  
gui = "",  
tty = "",  
},

rightSepHl = {  
bg = "#4c566a",  
ctermbg = 8,  
ctermfg = 7,  
fg = "#e5e9f0",  
},

rightSepHlAlt = {  
bg = "#4c566a",  
ctermbg = 8,  
ctermfg = 7,  
fg = "#e5e9f0",  
},  
}

### location <span id="location"></span>

{  
suffix = "",

dataHl = {  
bg = "#81a1c1",  
bold = true,  
ctermbg = 4,  
ctermfg = 0,  
fg = "#2e3440",  
},

dataHlAlt = {  
bg = "#4c566a",  
ctermbg = 8,  
ctermfg = 7,  
fg = "#e5e9f0",  
},

icon = {  
gui = "",  
tty = "",  
},

iconHl = {  
bg = "#81a1c1",  
bold = true,  
ctermbg = 4,  
ctermfg = 0,  
fg = "#2e3440",  
},

iconHlAlt = {  
bg = "#4c566a",  
ctermbg = 8,  
ctermfg = 7,  
fg = "#e5e9f0",  
},

leftPad = {  
gui = " ",  
tty = " ",  
},

leftSep = {  
gui = "",  
tty = "",  
},

leftSepHl = {  
bg = "#81a1c1",  
bold = true,  
ctermbg = 4,  
ctermfg = 0,  
fg = "#2e3440",  
},

leftSepHlAlt = {  
bg = "#4c566a",  
ctermbg = 8,  
ctermfg = 7,  
fg = "#e5e9f0",  
},

rightPad = {  
gui = " ",  
tty = " ",  
},

rightSep = {  
gui = "",  
tty = "",  
},

rightSepHl = {  
bg = "#81a1c1",  
bold = true,  
ctermbg = 4,  
ctermfg = 0,  
fg = "#2e3440",  
},

rightSepHlAlt = {  
bg = "#4c566a",  
ctermbg = 8,  
ctermfg = 7,  
fg = "#e5e9f0",  
},  
}

### mode <span id="mode"></span>

{  
suffix = "",

command = {  
bg = "#81a1c1",  
ctermbg = 4,  
},

insert = {  
bg = "#a3be8c",  
ctermbg = 2,  
},

leftPad = {  
gui = " ",  
tty = " ",  
},

leftSep = {  
gui = "",  
tty = "",  
},

normal = {  
bg = "#81a1c1",  
ctermbg = 4,  
},

replace = {  
bg = "#bf616a",  
ctermbg = 1,  
},

rightPad = {  
gui = " ",  
tty = " ",  
},

rightSep = {  
gui = "",  
tty = "",  
},

terminal = {  
bg = "#a3be8c",  
ctermbg = 2,  
},

visual = {  
bg = "#b48ead",  
ctermbg = 5,  
},  
}

### progress <span id="progress"></span>

{  
suffix = "",

dataHl = {  
bg = "#81a1c1",  
bold = true,  
ctermbg = 4,  
ctermfg = 0,  
fg = "#2e3440",  
},

dataHlAlt = {  
bg = "#4c566a",  
ctermbg = 8,  
ctermfg = 7,  
fg = "#e5e9f0",  
},

icon = {  
gui = "",  
tty = "",  
},

iconHl = {  
bg = "#81a1c1",  
bold = true,  
ctermbg = 4,  
ctermfg = 0,  
fg = "#2e3440",  
},

iconHlAlt = {  
bg = "#4c566a",  
ctermbg = 8,  
ctermfg = 7,  
fg = "#e5e9f0",  
},

leftPad = {  
gui = " ",  
tty = " ",  
},

leftSep = {  
gui = "",  
tty = "",  
},

leftSepHl = {  
bg = "#4c566a",  
ctermbg = 8,  
ctermfg = 4,  
fg = "#81a1c1",  
},

leftSepHlAlt = {  
bg = "#4c566a",  
ctermbg = 8,  
ctermfg = 8,  
fg = "#4c566a",  
},

rightPad = {  
gui = " ",  
tty = " ",  
},

rightSep = {  
gui = "",  
tty = "\|",  
},

rightSepHl = {  
bg = "#81a1c1",  
bold = true,  
ctermbg = 4,  
ctermfg = 0,  
fg = "#2e3440",  
},

rightSepHlAlt = {  
bg = "#4c566a",  
ctermbg = 8,  
ctermfg = 7,  
fg = "#e5e9f0",  
},  
}

### separator <span id="separator"></span>

{  
suffix = "",

active = {  
gui = "",  
tty = " ",  
},

dataHl = {  
bg = "#81a1c1",  
ctermbg = 0,  
ctermfg = 7,  
fg = "#2e3440",  
},

dataHlAlt = {  
bg = "#4c566a",  
ctermbg = 0,  
ctermfg = 7,  
fg = "#2e3440",  
},

inactive = {  
gui = "",  
tty = " ",  
},  
}

### type <span id="type"></span>

{  
suffix = "",

dataHl = {  
bg = "#4c566a",  
ctermbg = 8,  
ctermfg = 7,  
fg = "#e5e9f0",  
},

dataHlAlt = {  
bg = "#4c566a",  
ctermbg = 8,  
ctermfg = 7,  
fg = "#e5e9f0",  
},

icon = {  
gui = "",  
tty = "",  
},

iconHl = {  
bg = "#4c566a",  
ctermbg = 8,  
ctermfg = 7,  
fg = "#e5e9f0",  
},

iconHlAlt = {  
bg = "#4c566a",  
ctermbg = 8,  
ctermfg = 7,  
fg = "#e5e9f0",  
},

leftPad = {  
gui = " ",  
tty = " ",  
},

leftSep = {  
gui = "",  
tty = "\|",  
},

leftSepHl = {  
bg = "#4c566a",  
ctermbg = 8,  
ctermfg = 7,  
fg = "#e5e9f0",  
},

leftSepHlAlt = {  
bg = "#4c566a",  
ctermbg = 8,  
ctermfg = 7,  
fg = "#e5e9f0",  
},

rightPad = {  
gui = " ",  
tty = " ",  
},

rightSep = {  
gui = "",  
tty = "",  
},

rightSepHl = {  
bg = "#4c566a",  
ctermbg = 8,  
ctermfg = 7,  
fg = "#e5e9f0",  
},

rightSepHlAlt = {  
bg = "#4c566a",  
ctermbg = 8,  
ctermfg = 7,  
fg = "#e5e9f0",  
},  
}

## SEE ALSO <span id="SEE ALSO"></span>

*nvim*(1)

## AUTHOR <span id="AUTHOR"></span>

Kris Andrie Ortega (andrieee44@gmail.com)

------------------------------------------------------------------------
