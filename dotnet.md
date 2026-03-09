# .NET


usersecrets / user secrets / user-secrets
are found in `~/.microsoft/usersecrets/<guid-which-corresponds-to-csproj-file>/secrets.json`
`dotnet usersecrets init` writes to the .csproj file and creates the usersecrets file as json (empty json)
adding/chaning json values _(honestly its easier to just edit the file directly)_
`dotnet user-secrets set "Movies:ServiceApiKey" "12345" --project "$HOME/ribyns-pde"`


install efcore tools:
`dotnet tool install --global dotnet-ef`
