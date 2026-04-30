# Mouse and Key Bindings

> Documentation for Version 0.5.12
> [doc](https://pwmt.org/projects/zathura/documentation/)

## General

| Input | Description |
| :--- | :--- |
| J, PgDn | Go to the next page |
| K, PgUp | Go to the previous page |
| h, k, j, l | Scroll to the left, down, up or right direction |
| Left, Down, Up, Right | Scroll to the left, down, up or right direction |
| ^t, ^d, ^u, ^y | Scroll a half page left, down, up or right |
| t, ^f, ^b, space, <s-space>, y | Scroll a full page left, down, up or right |
| gg, G, nG | Goto to the first, the last or to the nth page |
| P | Snaps to the current page |
| H, L | Goto top or bottom of the current page |
| ^o, ^i | Move backward and forward through the jump list |
| ^j, ^k | Bisect forward and backward between the last two jump points |
| ^c, Escape | Abort |
| a, s | Adjust window in best-fit or width mode |
| /, ? | Search for text |
| n, N | Search for the next or previous result |
| o, O | Open document |
| f | Follow links |
| F | Display link target |
| c | Copy link target into the clipboard |
| \: | Enter command |
| r | Rotate by 90 degrees |
| ^r | Recolor (grayscale and invert colors) |
| R | Reload document |
| Tab | Show index and switch to **Index mode** |
| d | Toggle dual page view |
| D | Cycle opening column in dual page view |
| F5 | Switch to presentation mode |
| F11 | Switch to fullscreen mode |
| ^m | Toggle inputbar |
| ^n | Toggle statusbar |
| +, -, = | Zoom in, out or to the original size |
| zI, zO, z0 | Zoom in, out or to the original size |
| n= | Zoom to size n |
| mX | Set a quickmark to a letter or number X |
| 'X | Goto quickmark saved at letter or number X |
| q | Quit |

## Fullscreen mode

| Input | Description |
| :--- | :--- |
| J, K | Go to the next or previous page |
| space, <s-space>, <backspace> | Scroll a full page down or up |
| gg, G, nG | Goto to the first, the last or to the nth page |
| ^c, Escape | Abort |
| F11 | Switch to normal mode |
| +, -, = | Zoom in, out or to the original size |
| zI, zO, z0 | Zoom in, out or to the original size |
| n= | Zoom to size n |
| q | Quit |

## Presentation mode

| Input | Description |
| :--- | :--- |
| space, <s-space>, <backspace> | Scroll a full page down or up |
| ^c, Escape | Abort |
| F5 | Switch to normal mode |
| q | Quit |

## Index mode

| Input | Description |
| :--- | :--- |
| k, j | Move to upper or lower entry |
| l | Expand entry |
| L | Expand all entries |
| h | Collapse entry |
| H | Collapse all entries |
| space, Return | Select and open entry |

## Mouse bindings

| Input | Description |
| :--- | :--- |
| Scroll | Scroll up or down |
| ^Scroll | Zoom in or out |
| Drag Button2 (middle button drag) | Pan the document |
| Button1 (left click) | Follow link |
| Drag Button1 | Select text |
| Drag S-Button1 | Highlight region |
| Button3 (right click) | Open popup menu to copy/save image (activates for images recognized by `export` command) |

# Commands

| Command | Description |
| :--- | :--- |
| bmark | Save a bookmark |
| bdelete | Delete a bookmark |
| blist | List bookmarks |
| bjump | Jump to given bookmark |
| jumplist | Show recent jumps in jumplist (by default last 5). Optional argument specifies number of entries to show. Negative value "-N" shows all except the first "N" entries |
| mark | Set a quickmark |
| delmarks | Delete a quickmark. Abbreviation: `delm` |
| close | Close document |
| quit | Quit zathura. Abbreviation: `q` |
| exec | Execute an external command. `$FILE` expands to the current document path, `$PAGE` to the current page number, and `$DBUS` to the bus name of the D-Bus interface. Alias: `!` (space is still needed after) |
| info | Show document information |
| open | Open a document. Abbreviation: `o` |
| offset | Set page offset |
| print | Print document |
| write(!) | Save document (and force overwriting). Alias: `save(!)` |
| export | Export attachments. First argument specifies the attachment identifier (use completion with `Tab`), second argument gives the target filename (relative to current working directory) |
| dump | Write values, descriptions, etc. of all current settings to a file |
| source | Source a configuration file. It is possible to change the config directory by passing an argument |
| hlsearch | Highlight current search results |
| nohlsearch | Remove highlights of current search results. Abbreviation: `nohl` |
| version | Show version information. |

# SyncTeX Support

Both synctex forward and backwards synchronization are supported by zathura. To enable synctex forward synchronization, please look at the *--synctex-forward* and *--synctex-editor* options. zathura will also emit a signal via the D-Bus interface. To support synctex backwards synchronization, zathura provides a D-Bus interface that can be called by the editor. For convenience zathura also knows how to parse the output of the *synctex view* command. It is enough to pass the arguments to *synctex view*'s *-i* option to zathura via *--synctex-forward* and zathura will pass the information to the correct instance.

For gvim forward and backwards synchronization support can be set up as follows: First add the following to the vim configuration:

```vim
function! Synctex()
  execute "silent !zathura --synctex-forward " . line('.') . ":" . col('.') . ":" . bufname('%') . " " . g:syncpdf
  redraw!
endfunction
map <C-enter> :call Synctex()<cr>
```

Then launch *zathura* with

```bash
zathura -x "gvim --servername vim -c \"let g:syncpdf='$1'\" --remote +%{line} %{input}" $file
```

Some editors support zathura as viewer out of the box:

- LaTeXTools for [SublimeText](https://latextools.readthedocs.io/en/latest/available-viewers/#zathura)
- LaTeX for [Atom](https://atom.io/packages/latex)

# Configuration

The customization of zathura is managed via a configuration file called *zathurarc*. By default zathura will evaluate the following files:

- */etc/zathurarc*
- *$XDG_CONFIG_HOME/zathura/zathurarc* (default: ~/.config/zathura/zathurarc)

The *zathurarc* file is a simple plain text file that can be populated with various commands to change the behaviour and the look of zathura which we are going to describe in the following subsections. Each line (besides empty lines and comments (which start with a prepended *#*)) is evaluated on its own, so it is not possible to write multiple commands in one single line.

## set - Changing options

In addition to the built-in *:set* command zathura offers more options to be changed and makes those changes permanent. To overwrite an option you just have to add a line structured like the following:

```
set <option> <new value>
```

The *option* field has to be replaced with the name of the option that should be changed and the *new value* field has to be replaced with the new value the option should get. The type of the value can be one of the following:

- INT - An integer number
- FLOAT - A floating point number
- STRING - A character string
- BOOL - A boolean value ("true" for true, "false" for false)

In addition we advise you to check the options to get a more detailed view of the options that can be changed and which values they should be set to.

The following example should give some deeper insight of how the *set* command can be used:

```
set option1 5
set option2 2.0
set option3 hello
set option4 hello\ world
set option5 "hello world"
set option6 "#00BB00"
```

Especially for options with strings as values, note that escaping of special characters and white spaces is necessary. In the above example, `option4` and `option5` are both set to `hello world`, but `set option6 hello world` would set `option6` only to `hello`.

For colors, zathura supports HTML color codes and CSS3-style `rgb(r,g,b)` and `rgba(r,g,b,a)` values. If you want to use color codes for some options, make sure to quote them accordingly or to escape the hash symbol.

```
set default-fg "#CCBBCC"
set default-fg \#CCBBCC
```

For `rgba`, note that it parses the color components as integers between 0 and 255 and the alpha component as float between 0 and 1.

## include - Including another config file

This command allows one to include other configuration files. If a relative path is given, the path will be resolved relative to the configuration file that is currently processed.

```
include another-config
```

## map - Mapping a shortcut

It is possible to map or remap new key bindings to shortcut functions which allows a high level of customization. The *:map* command can also be used in the *zathurarc* file to make those changes permanent:

```
map [mode] <binding> <shortcut function> <argument>
```

### Mode

The *map* command expects several arguments where only the *binding* as well as the *shortcut-function* argument is required. Since zathura uses several modes it is possible to map bindings only for a specific mode by passing the *mode* argument which can take one of the following values:

- normal (default)
- fullscreen
- presentation
- index

The brackets around the value are mandatory.

#### Single key binding

The (possible) second argument defines the used key binding that should be mapped to the shortcut function and is structured like the following. On the one hand it is possible to just assign single letters, numbers or signs to it:

```
map a shortcut_function optional_argument
map b shortcut_function optional_argument
map c shortcut_function optional_argument
map 1 shortcut_function optional_argument
map 2 shortcut_function optional_argument
map 3 shortcut_function optional_argument
map ! shortcut_function optional_argument
map ? shortcut_function optional_argument
```

#### Using modifiers

It is also possible to use modifiers like the *Control* or *Alt* button on the keyboard. It is possible to use the following modifiers:

- A - *Alt*
- C - *Control*
- S - *Shift*

If any of the modifiers should be used for a binding, it is required to define the `binding` with the following structure:

```
map <A-a> shortcut_function
map <C-a> shortcut_function
```

#### Special keys

zathura allows it also to assign keys like the space bar or the tab button which also have to be written in between angle brackets. The following special keys are currently available:

| Identifier | Description |
| :--- | :--- |
| BackSpace | Back space |
| CapsLock | Caps lock |
| NumLock | Num Lock |
| ScrollLock | Scroll Lock |
| Esc | Escape |
| Down | Arrow down |
| Up | Arrow up |
| Left | Arrow left |
| Right | Arrow right |
| F1 | F1 |
| F2 | F2 |
| F3 | F3 |
| F4 | F4 |
| F5 | F5 |
| F6 | F6 |
| F7 | F7 |
| F8 | F8 |
| F9 | F9 |
| F10 | F10 |
| F11 | F11 |
| F12 | F12 |
| PageDown | Page Down |
| PageUp | Page Up |
| Return | Return |
| Space | Space |
| Super | Windows key |
| Tab | Tab |
| Print | Print key |
| KPUp | Numpad Up (where the number 8 is) |
| KPDown | Numpad Down (where the number 2 is) |
| KPLeft | Numpad Left (where the number 4 is) |
| KPRight | Numpad Right (where the number 6 is) |
| KPBegin | Numpad Center button (where the number 5 is) |
| KPPrior | Numpad PageUp (where the number 9 is) |
| KPPageUp | Numpad PageUp (where the number 9 is) |
| KPNext | Numpad PageDown (where the number 3 is) |
| KPPageDown | Numpad PageDown (where the number 3 is) |
| KPHome | Numpad Home (where the number 7 is) |
| KPEnd | Numpad End (where the number 1 is) |
| KPInsert | Numpad Insert (where the number 0 is) |
| KPDelete | Numpad Delete (where the numpad period is) |
| KPMultiply | Numpad Asterisk |
| KPAdd | Numpad Plus sign |
| KPSubtract | Numpad Minus sign |
| KPDivide | Numpad Slash sign |

Of course it is possible to combine those special keys with a modifier. The usage of those keys should be explained by the following examples:

```
map <Space> shortcut_function
map <C-Space> shortcut_function
```

#### Mouse buttons

It is also possible to map mouse buttons to shortcuts by using the following special keys:

| Identifier | Description |
| :--- | :--- |
| Button1 | *Mouse button 1* |
| Button2 | *Mouse button 2* |
| Button3 | *Mouse button 3* |
| Button4 | *Mouse button 4* |
| Button5 | *Mouse button 5* |

They can also be combined with modifiers:

```
map <Button1> shortcut_function
map <C-Button1> shortcut_function
```

#### Buffer commands

If a mapping does not match one of the previous definitions but is still a valid mapping it will be mapped as a buffer command:

```
map abc quit
map test quit
```

#### Shortcut functions

The following shortcut functions can be mapped:

| Function | Arguments | Description |
| :--- | :--- | :--- |
| abort | | Switch back to normal mode. |
| adjust_window | `best-fit`, `width` | Adjust page width. |
| bisect | `forward`, `backward` | Bisect through the document. |
| change_mode | | Change current mode. |
| cycle_first_column | | Cycle the column in which the first page is displayed<br>(multi-page layout). |
| display_link | | Display link target. |
| exec | | Execute an external command. `$FILE`: document path,<br>`$PAGE`: page number, `$DBUS`: D-Bus bus name. |
| file_chooser | | Open File Chooser. Uses native on Win/macOS,<br>portals if available, or GtkFileChooser. |
| focus_inputbar | | Focus inputbar. |
| follow | | Follow a link. |
| goto | page number | Go to a certain page. |
| jumplist | `forward`, `backward` | Move forwards/backwards in the jumplist. |
| navigate | `next`, `previous` | Navigate to the next/previous page. |
| navigate_index | `top`, `bottom`, `up`, `down`, `half-up`, `half-down`, `partial-up`, `partial-down`, `expand`, `collapse`, `expand-all`, `collapse-all`, `toggle`, `select` | Navigate through the index. |
| nohl_search | | Remove search highlights. |
| print | | Show the print dialog. |
| quit | | Quit zathura. |
| recolor | | Recolor pages. |
| reload | | Reload the document. |
| rotate | `rotate-ccw`, `rotate-cw` | Rotate the page. |
| scroll | `top`, `bottom`, `page-top`, `page-bottom`, `full-up`, `full-down`, `full-left`, `full-right`, `half-up`, `half-down`, `partial-up`, `partial-down`, `half-left`, `half-right`, `up`, `down`, `left`, `right`, `bidirectional` | Scroll. |
| search | `forward`, `backward` | Search next/previous item. |
| set | | Set an option. |
| snap_to_page | | Snaps to the current page (same as `goto <current_page>`). |
| toggle_fullscreen | | Toggle fullscreen. |
| toggle_index | | Show or hide index. |
| toggle_inputbar | | Show or hide inputbar. |
| toggle_page_mode | | Toggle between one and multiple pages per row. |
| toggle_statusbar | | Show or hide statusbar. |
| zoom | `in`, `out` | Zoom in or out. |
| mark_add | | Set a quickmark. |
| mark_evaluate | | Go to a quickmark. |
| feedkeys | | Simulate keys. Uppercase uses conventions like `<s-x>`. |

#### Pass arguments

Some shortcut functions require or have optional arguments which influence the behaviour of them. Those can be passed as the last argument:

```
map <C-i> zoom in
map <C-o> zoom out
```

### unmap - Removing a shortcut

In addition to mapping or remapping custom key bindings it is possible to remove existing ones by using the *:unmap* command. The command is used in the following way (the explanation of the parameters is described in the *map* section of this document):

```
unmap [mode] <binding>
```

# Options

## girara

| Setting | Type | Default Value | Description |
| :--- | :--- | :--- | :--- |
| n-completion-items | Integer | 15 | Maximum number of displayed completion entries. |
| completion-bg | String | #232323 | Defines the background color that is used for command line completion |
| completion-fg | String | #DDDDDD | Defines the foreground color that is used for command line completion entries |
| completion-group-bg | String | #000000 | Defines the background color that is used for command line completion group elements |
| completion-group-fg | String | #DEDEDE | Defines the foreground color that is used for command line completion group elements |
| completion-highlight-bg | String | #9FBC00 | Defines the background color that is used for the current command line completion element |
| completion-highlight-fg | String | #232323 | Defines the foreground color that is used for the current command line completion element |
| default-bg | String | #000000 | Defines the default background color |
| default-fg | String | #DDDDDD | Defines the default foreground color |
| exec-command | String | | Defines a command the should be prepended to any command run with exec. |
| font | String | monospace normal 9 | Defines the font that will be used |
| guioptions | String | s | Shows or hides GUI elements. 'c': command line, 's': statusbar, 'h': horizontal scrollbar, 'v': vertical scrollbar |
| inputbar-bg | String | #131313 | Defines the background color for the inputbar |
| inputbar-fg | String | #9FBC00 | Defines the foreground color for the inputbar |
| notification-bg | String | #FFFFFF | Defines the background color for a notification |
| notification-fg | String | #000000 | Defines the foreground color for a notification |
| notification-error-bg | String | #FF1212 | Defines the background color for an error notification |
| notification-error-fg | String | #FFFFFF | Defines the foreground color for an error notification |
| notification-warning-bg | String | #FFF712 | Defines the background color for a warning notification |
| notification-warning-fg | String | #FFFFFF | Defines the foreground color for a warning notification |
| statusbar-bg | String | #000000 | Defines the background color of the statusbar |
| statusbar-fg | String | #FFFFFF | Defines the foreground color of the statusbar |
| statusbar-h-padding | Integer | 8 | Defines the horizontal padding of the statusbar and notificationbar |
| statusbar-v-padding | Integer | 2 | Defines the vertical padding of the statusbar and notificationbar |
| window-icon | String | | Defines the path for a icon to be used as window icon. |
| window-height | Integer | 600 | Defines the window height on startup |
| window-width | Integer | 800 | Defines the window width on startup |

## zathura

This section describes settings concerning the behaviour of zathura.

| Setting | Type | Default Value | Description |
| :--- | :--- | :--- | :--- |
| abort-clear-search | Boolean | true | Clear search results on abort. |
| adjust-open | String | best-fit | Auto adjustment mode on load ("best-fit", "width"). |
| advance-pages-per-row | Boolean | false | Honor pages-per-row when advancing. |
| continuous-hist-save | Boolean | false | Save history at each page change (instead of on close). |
| database | String | plain | Database backend ("plain", "sqlite", "null").<br>"plain" is deprecated; "sqlite" will import its history. |
| dbus-raise-window | Boolean | true | Raise window when receiving D-Bus commands. |
| dbus-service | Boolean | true | En/Disable D-Bus (required for SyncTeX). |
| double-click-follow | Boolean | true | Trigger link follow on double click. |
| filemonitor | String | glib | File monitor backend ("glib", "signal", "noop"). |
| first-page-column | String | 1:2 | Column for first page. Formatted as<br>`<1 per row>:[<2 per row>[: ...]]`. |
| highlight-active-color | String | rgba(0,188,0,0.5) | Color for current highlighted element. |
| highlight-color | String | rgba(159,251,0,0.5) | Color for document highlights (e.g. search results). |
| highlight-fg | String | rgba(0,0,0,0.5) | Color for text in highlighted parts. |
| highlighter-modifier | String | shift | Modifier for drawing highlighter ("shift", "ctrl", "alt"). |
| incremental-search | Boolean | true | En/Disable search while typing. |
| index-active-bg | String | #9FBC00 | Background for selected element in index mode. |
| index-active-fg | String | #232323 | Foreground for selected element in index mode. |
| index-bg | String | #232323 | Background for index mode. |
| index-fg | String | #DDDDDD | Foreground for index mode. |
| jumplist-size | Integer | 2000 | Max positions to remember in jumplist. |
| link-hadjust | Boolean | true | Align internal link targets to the left. |
| link-zoom | Boolean | true | Change zoom when following links. |
| nohlsearch | Boolean | false | Dis/Enable search result highlighting. |
| open-first-page | Boolean | false | Always open on first page (ignore last position). |
| page-cache-size | Integer | 15 | Max cached pages. High values consume more memory. |
| page-v-padding | Integer | 1 | Vertical gap (px) between pages. |
| page-h-padding | Integer | 1 | Horizontal gap (px) between pages. |
| page-right-to-left | Boolean | false | Multi-column view starts from right. |
| page-thumbnail-size | Integer | 4M | Max size (px) of thumbnail cache per page.<br>Higher = better quality, more memory. |
| pages-per-row | Integer | 1 | Number of pages rendered side-by-side. |
| recolor | Boolean | false | En/Disable recoloring. |
| recolor-adjust-lightness | Boolean | false | Adjust lightness when recoloring. |
| recolor-darkcolor | String | #FFFFFF | Color for dark parts in recoloring mode. |
| recolor-keephue | Boolean | false | Keep original hue when recoloring. |
| recolor-lightcolor | String | #000000 | Color for light parts in recoloring mode. |
| recolor-reverse-video | Boolean | false | Keep original image colors while recoloring. |
| render-loading | Boolean | true | Display "Loading..." text during rendering. |
| render-loading-bg | String | #FFFFFF | Background for "Loading..." text. |
| render-loading-fg | String | #000000 | Foreground for "Loading..." text. |
| scroll-full-overlap | Float | 0 | Proportion of area visible after full page scroll. |
| scroll-hstep | Float | -1 | Horizontal step size for scroll command. |
| scroll-step | Float | 40 | Step size for scroll command. |
| scroll-page-aware | Boolean | false | Scrolling stops at page boundaries. |
| scroll-wrap | Boolean | false | Wrap last/first page. |
| search-hadjust | Boolean | true | Horizontally center search results. |
| selection-clipboard | String | primary | X clipboard for selection ("clipboard", "primary"). |
| selection-notification | Boolean | true | Display notification after selecting text. |
| signature-error-color | String | rgba(...) | BG color for signatures with errors. |
| signature-success-color | String | rgba(...) | BG color for valid signatures. |
| signature-warning-color | String | rgba(...) | BG color for signatures with warnings. |
| show-directories | Boolean | true | Display directories in completion. |
| show-hidden | Boolean | false | Display hidden files/dirs in completion. |
| show-recent | Integer | 10 | Number of recent files in completion. 0 to disable. |
| show-signature-information | Boolean | false | Display embedded signature info. |
| statusbar-basename | Boolean | false | Use basename of file in statusbar. |
| statusbar-home-tilde | Boolean | false | Replace $HOME with ~ in statusbar. |
| statusbar-page-percent | Boolean | false | Display (page / total) as % in statusbar. |
| synctex | Boolean | true | En/Disable SyncTeX backward sync. |
| synctex-edit-modifier | String | ctrl | Modifier for SyncTeX backward sync. |
| synctex-editor-command | String | | Command for SyncTeX backward sync. |
| vertical-center | Boolean | false | Center screen at vertical midpoint of page. |
| window-icon-document | Boolean | false | Update window icon based on first page. |
| window-title-basename | Boolean | false | Use basename of file in window title. |
| window-title-home-tilde | Boolean | false | Replace $HOME with ~ in window title. |
| window-title-page | Boolean | false | Display page number in window title. |
| zoom-center | Boolean | false | Horizontally center zooming. |
| zoom-max | Integer | 1000 | Max zoom percentage. |
| zoom-min | Integer | 10 | Min zoom percentage. |
| zoom-step | Integer | 10 | Zoom amount (%) per command. |



