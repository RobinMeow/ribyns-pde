- keep all install-app.sh seperately as before.
- design them to be invokeable in the cli for direct execution and when sourced they provide sync-app and install-app functions (where sync will only copy config files and install will install deps and the app itself as required)
- upgrade to set -euo pipefail where it makes sense
- extend the zshrc with autocompletion for a syntax like this "ribyn install appname" and "ribyn sync appname"
- consider a third term for install+sync, or having sync implicitly included in install (i think the latter makes more sense)
- scripts which are executed should not use .sh suffix, since not common https://google.github.io/styleguide/shellguide.html#s2.1-file-extensions
- move ng-test.sh and similars to bin/ngtest and have it added to path by zshrc
- all errors should use stderr not stdout
- read the google styleguide its not that long


recommended dir structure by ai1 for this repo:

```
dotfiles/
├── bootstrap/        # entrypoints
│   ├── install
│   ├── sync
│   └── doctor
│
├── modules/          # domain modules
│   ├── nvim/
│   │   ├── files/
│   │   │   └── .config/nvim/
│   │   ├── install
│   │   ├── build
│   │   ├── sync
│   │   └── README.md
│   │
│   ├── hypr/
│   ├── kitty/
│   ├── tmux/
│   ├── zsh/
│   ├── git/
│   ├── mpd/
│   └── virt/
│
├── bin/              # personal CLI tools (synced to ~/bin)
│   ├── ng-test
│   ├── timer
│   ├── chrono
│   ├── webpify
│   └── mount-pc-white
│
├── lib/              # reusable shell libraries
│   ├── os.sh
│   ├── package-manager.sh
│   ├── fs.sh
│   ├── logging.sh
│   └── utils.sh
│
├── docs/             # markdown knowledgebase
│   ├── arch-install.md
│   ├── linux.md
│   ├── hyprland.md
│   └── ollama.md
│
├── assets/           # non-config assets
│   ├── images/
│   ├── sounds/
│   └── wallpapers/
│
├── state/            # generated/cache/runtime
├── tmp/
└── README.md
```

more recommendations by ai2:

```
.
├── config
│   ├── nvim
│   │   ├── init.lua
│   │   ├── install-nvim.sh  <-- Functions: sync_nvim, build_nvim
│   │   └── lua/
│   ├── hypr
│   │   ├── hyprland.conf
│   │   └── install-hypr.sh
├── bin  <-- SYNCED TO ~/bin
│   ├── ng-test              <-- (Renamed from ng-test.sh)
│   └── chrono               <-- (Renamed from chrono.sh)
├── core
│   ├── os-detect.sh
│   ├── utils.sh
│   └── install.sh           <-- Sources ./config/**/install-*.sh
```

```
.
├── modules
│   ├── nvim
│   │   ├── setup.sh         <-- Installation/Sync logic
│   │   └── README.md
│   ├── system
│   │   ├── arch-install.sh
│   │   └── pacman-list.txt
│   └── network
│       └── gen-ssh.sh
├── bin                      <-- Your PATH tools
└── config                   <-- Only the dotfiles
```

