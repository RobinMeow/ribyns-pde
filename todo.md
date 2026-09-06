# Tasks

full install tests:

- arch only i think; cargo breaks ci on first install,
  asking if install from rust or rustup
- hypr wayland-protocol is missing on wob install

- [https://wiki.hypr.land/configuring/core/config-options/#group-colors](https://wiki.hypr.land/configuring/code-snippets/#minimize-windows-using-special-workspaces)
- make swappy a tiled window. window rule didnt work
- [hypr group management](https://wiki.hypr.land/configuring/code-snippets/#vim-like-keymaps)
  could allow me to get rid of hy3, and use colored group borders if possible to
  [visualize group management when in keymap](https://wiki.hypr.land/configuring/core/config-options/#group-colors)
- replace waybar with quickshell and have whatsapp/thunderbird icons for unread messages
- discord automated install is missing. requires non-free rpm on fedora
- [mpv-cut](https://github.com/familyfriendlymikey/mpv-cut) plugin for mpv for cutting videos or audio
  or [lazycut](https://github.com/ozemin/lazycut) also supports video triming
  or [tui-wave](https://github.com/biomassa/tui-wave) which is only for audio
- shared partition in exFAT
- portable linux (a nvme in an enclosure)
- automate backups
- learn about security, and apply some basic stuff like firewall
- configure dunst to have a timer and build tools based on it `notify-send "test"`
- checkout [palemoon](https://github.com/RealityRipple/Pale-Moon) as alternative
  browser to firefox
- password manager from the ebook. and make it compatible for android using termux
- rmpc primary color is too neon like. need more pastel like
- depends on firefox;make a cli tool to replace the need for bookmarks
- some cli bin which invokes firefox --search my-search-text
- consider replacing apps like rofi, with quickshell. quickshell everwhere.

# Further Education

- [practical bash scripting: what AI cant teach you](https://www.youtube.com/watch?v=aqEIE6Jn0mU)
- learn sed
- continue on [learn cpp chapter 11](https://www.learncpp.com/cpp-tutorial/implicit-type-conversion/)

## app ideas

- tui to manage ~/.config/ribyn/local-env.sh
- music dl (TUI) yt-dlp
- audio cutting tui
- calendar for birthdays (family sharable sync in Android?)
- Ribyn-Distro installer
- jesus parables

## Fedora

- virtualization is not tested

## Kitty

- continue reading through the example config

## Neovim

- checkout these tree sitter parsers, they sound interesting
  `git_config	unstable	HF J 	@amaanq`
  `git_rebase	unstable	H  J 	@gbprod`
  `gitattributes	unstable	H  JL	@ObserverOfTime`
  `gitcommit	unstable	H  J 	@gbprod`
  `gitignore	unstable	H  J 	@theHamsta`
- consider cnext keybinds
  `vim.keymap.set("n", "<leader>cn", ":cnext<CR>")`
  `vim.keymap.set("n", "<leader>ct", ":cprev<CR>")`
  `vim.keymap.set("n", "<leader>cc", ":cclose<CR>")`
  `vim.keymap.set("n", "<leader>cf", ":cnfile<CR>")`
- close all buffers and reopen last edited `vim.keymap.set("n", "cab", ":%bd|e#|bd#<CR><C-O><CR>")` (close all but current would be nicer)
- [remove unused imports example](https://github.com/nvim-telescope/telescope.nvim/issues/3328#issuecomment-2977174031)
  `vim.keymap.set('n', 'gro', organizeImports, { buffer = bufnr,  remap = false, desc = "Reorganize imports"});`
- [prevent double rename](https://github.com/nvim-telescope/telescope.nvim/issues/3328#issuecomment-2472420006)
- lsp-linked_editing_range (e.g. auto update closing tags html) [telescope dedup](https://github.com/nvim-telescope/telescope.nvim/issues/3328)
- review prs from github/gitlab in neovim [atlas.nvim](https://github.com/emrearmagan/atlas.nvim)
  I have not yet compared this to other plugins. Just as an idea
- use go typescript compiler for my new CompileTsc
- consider swapping from snacks to nvim-notify looks better and i wanna get rid of snacks
- increase git diffview left panel default width
- strike trhough words when deprecated
- vim._core.ui2 configure it to be me useable
- custom emoji loader :) see spinners.json origin: https://github.com/zadirion/Unreal.nvim/blob/main/lua/spinners.json
- text to neovim (voice: change inner word)
- keymap for search config which lets me use telescope fuzzy serach for dirs in .config (not only neovim and hypr)
- neovim tests against all my config
- enable tildeop with operator
- harpoon https://github.com/ThePrimeagen/harpoon/tree/harpoon2
- read :help lua-guide
- learn native nvim motions and operations before re-enableing mini.surround/flash plugins
- current restore session solution, is good enough. but if i desore restored terminals or DBUI, or quickfix lists i might want to look for plugin
- virtual text for debugging https://github.com/theHamsta/nvim-dap-virtual-text?utm_source=chatgpt.com
- show cmd line in the middle of the screen for pair programming
- populate tsc/tsgo/lint errors into quickfix

## zsh / omz

- learn about the magic space
- add bible verses as message of the day

## Hyprland

decided to wait at least until im no longer on nvidia. Even pre-configured "themes" have an install scripts which will auto download open-nvidia-dkms driver or sth, and i dont wanna mess with my working system, nor maintain 4 versions of hyprland to have the same desktop env on my lenovo (amd), macbook (intel?) and pc (nvidia). and only my bluetooth keyboard in qwerty

## deferred

- build hyprwarp and dotool from source on hyprwarp branch
  becuase, dotool doesnt use modern reduced permission ctl using uaccess

## random notes

- let Robin know about mise (nvm improvement)

[30 vim commands must-know: refresher for features which exist](https://www.youtube.com/watch?v=RSlrxE21l_k)

- [yazi bulk rename](https://yazi-rs.github.io/features/)
- [yazi tips and tricks e.g. drag and drop](https://yazi-rs.github.io/docs/tips/#drag-and-drop)

- https://makefiletutorial.com
- make sure simple kind of man is in my music playlist
- [rclone to sync cloud as a mounted filesystem](https://github.com/rclone/rclone)

# Walkolution

wd40 zum nachschmieren
