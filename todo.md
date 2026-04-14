# TicketSystem

## prio quick todos

- use built in diffview, ui2, undotree and add keybinds for :restart
```
[diff]
tool = nvim_difftool
[difftool "nvim_difftool"]
cmd = nvim -c \"packadd nvim.difftool"\ -c \"DiffTool $LOCAL $REMOTE\"
```
- make own zsh prompt https://github.com/romkatv/powerlevel10k
- add safe boot option (Arch Safe boot) to grub menu, in case libinput breaks again or sth
- better terminal integration. nice would be if i could show the terminal state as a split/pane show/hide as needed
- harpoon https://github.com/ThePrimeagen/harpoon/tree/harpoon2
- stay up2date with kickstarter e.g. auto show the diagnostic window when using diagnostic jump https://github.com/nvim-lua/kickstart.nvim/commit/21d5aabc22ac44fc9404953a0b77944879465dd0

## prio but high time investment

- compare open source llm and build one local so i can use it in as cli
- Telescope builtin pickers to keymaps mappen und lernen welche es gibt

# low prio

- highlight current row cursor is on in buffer and telescope
- tab view is so bad when it shortens to ...
- ng-test-fzf.sh is runniung duplicated tests...
- consider floating cmdline. i think nice for pair-p https://github.com/VonHeikemen/fine-cmdline.nvim
- seemless wezterm (using ctrl hjkl to switch panes from nvim to wezterm and using the same binds in wezterm and nvim)
- math algo to increase the step amount on brightness change the brighter it gets and decrease its accuracy to less it gets but still allow reaching 0
- source control btop conf
- use `time` to add execution duration to all scripts
- nvim restore previous session `:mksession filename.vim` and load with `nvim -S filename.vim`. doesnt work for quick fix list. so a plugin is probably worthline. perfeable one which supports different nvim workspaces
_ consider hand written workspice files in lua. BUt for that I wanna collect more lua experience
- markdown viewer? https://github.com/iamcco/markdown-preview.nvim not sure if i need sth like that
- Debugging in nvim? not sure if i care about this. im fine with using windows for debugging for now.
- stay up 2 date on kickstarter commits to see i want to take those changes e.g. https://github.com/nvim-lua/kickstart.nvim/commit/21d5aabc22ac44fc9404953a0b77944879465dd0
- instead of using fortune it would be cool to have 97 things every programmer should know (their titles) as reminders
- add a shell cript for cloning this repo with installation instruction in readme
- todo counter for winbar in lualine
- tokei if there is enough space for snacks dashboard
- https://github.com/jesseduffield/lazydocker
- Keybind for folding methods in csharp with and without namespaces maybe also for ts? or keybinds like vs code, based on indent level
- dashboard could be responsive based on available space. the maintainer said sth about it in the "Share your dashboard" thread
- install sciprt for cloning and building ascii image converter https://github.com/TheZoraiz/ascii-image-converter

## Explicitly-Discarded

- terminal based browser wont do my ant good
- rove ascii art (didnt look so good. no good fanart)

## random notes

tools videos:
https://www.youtube.com/watch?v=b5SUAuQ69jU
https://www.youtube.com/watch?v=3fVAtaGhUyU

https://github.com/mrjones2014/smart-splits.nvim?tab=readme-ov-file#wezterm
https://github.com/atuinsh/atuin magic shell history (do I need this with zsh?)
fancy modern file manager https://github.com/yorukot/superfile
pastel idc color finder? https://github.com/sharkdp/pastel
navi cheatsheet for cli cmds https://github.com/denisidoro/navi
document reader https://github.com/kruseio/hygg

[30 vim commands must-know: refresher for features which exist](https://www.youtube.com/watch?v=RSlrxE21l_k)

## Future plans:

- podman https://github.com/containers/podman
- devbox?
- testcontainers?
- toggle background brightness


# interesting open source tools

- ffmpeg converting media files of all sorts (used it to convert mp4 to animated webp as wezterm background)
- [convert files to markdown](https://github.com/microsoft/markitdown)
- [li progress bar](https://github.com/tqdm/tqdm)
- [display rich text beatiful in the terminal](https://github.com/Textualize/rich)

