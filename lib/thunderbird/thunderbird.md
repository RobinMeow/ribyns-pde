# thunderbird

there is not really a good email client out there.
just like browsers.
But I'd rather have a dedicated email client than using the browser.

## initial setup

- use email as full name
- allow access only to emails, not contacts, not calendars

### settings > general

**get rid of the welcome to freedom message:**
uncheck `When Thunderbird launches, show the Start Page in the message area`

open messages in: `a new message window`

unceck `Show only display name for people in my address book`

### settings > appearance

accent color `purple`
cards view options: row count: `2 rows`
sorting and threading, default threading: `unthreaded`

### settings > composition

disable spellcheck as you type

### settings > privacy and security

uncheck `allow thunderbird to send technical and interaction data to Mozilla`

### set thunderbird as default os email client for mailto

it has set itself upon installation. wonderful :)
so you don't need to do anything.

read current:
`xdg-mime query default x-scheme-handler/mailto`
`xdg-settings get default-url-scheme-handler mailto`

set thunderbird:
`xdg-settings set default-url-scheme-handler mailto thunderbird.desktop`
`xdg-mime default thunderbird.desktop x-scheme-handler/mailto`
