# .NET

### CSharp LSP

install .NET stuff and add `~/.dotnet/tools`  to the path variable
because its recommended tho use those to install the csharp-ls
`dotnet tool install --global csharp-ls`
[wiki archlinux .NET](https://wiki.archlinux.org/title/.NET)

## EFCore

install efcore tools:
`dotnet tool install --global dotnet-ef`

## UserSecrets

usersecrets / user secrets / user-secrets
are found in `~/.microsoft/usersecrets/<guid-which-corresponds-to-csproj-file>/secrets.json`
`dotnet usersecrets init` writes to the .csproj file and creates the usersecrets file as json (empty json)
adding/chaning json values _(honestly its easier to just edit the file directly)_
`dotnet user-secrets set "Movies:ServiceApiKey" "12345" --project "$HOME/ribyns-pde"`

## other useful stuff I learned

you can install templates with the dotnet cli. e.g. xunit3 classlib

## NVIM

dotnet (meaning, microslop) is a mess, I use easy-dotnet nvim plugin now, 
which is bloated but works pretty reliably at least.
