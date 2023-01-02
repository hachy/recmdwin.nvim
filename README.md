# recmdwin.nvim

Recmdwin is just a wrapper of command-line window(cmdwin).

## Features

- Ignore `w`, `q`, etc, in cmdline history.
- `q` in normal mode closes window.

## Installation

With [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'hachy/recmdwin.nvim'
```

## Setup

```vim
lua <<EOF
require("recmdwin").setup({})

vim.keymap.set("n", ":", "q:")
EOF
```
