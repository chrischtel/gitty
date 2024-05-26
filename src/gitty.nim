import httpclient,  os
import std/strutils

# Funktion, um die gitignore-Vorlage für eine bestimmte Sprache/Tool abzurufen

# Funktion, um eine .gitignore-Datei zu erstellen

# Funktion, um CLI-Argumente zu verarbeiten
proc parseArgs(): (seq[string], string) =
  let args = commandLineParams() 
  if args.len < 1:
    quit("Please specify a language or a tool: gitty <lang>")

  var languages = newSeq[string]()
  var filename = ".gitignore"

  for arg in args:
      languages.add(arg)

  return (languages, filename)

# Hauptprogramm
let (languages, filename) = parseArgs()

proc fetchGitignoreTemplate(languages: seq[string]): string =
  let url = "https://www.toptal.com/developers/gitignore/api/" & languages.join(",")
  var client = newHttpClient()
  try:
    return client.getContent(url)
  finally:
    client.close()

proc createFile(content: string): void =
  let lines = content.splitLines()
  let filteredLines = lines[2 .. lines.len-3]
  let filteredContent = filteredLines.join("\n")
  writeFile(".gitignore", filteredContent)
  echo "Die .gitignore wurde erfolgreich erstell"

let cont = fetchGitignoreTemplate(languages)
createFile(cont)

