FROM alpine/git:1.0.7

LABEL "name"="commit-changes"
LABEL "maintainer"="Geir Gåsodden <geir.gasodden@pythonia.no>"
LABEL "version"="1.0.0"

LABEL "com.github.actions.name"="Commit changes"
LABEL "com.github.actions.description"="Commits changes back to master"
LABEL "com.github.actions.icon"="git"
LABEL "com.github.actions.color"="orange"

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["sh", "/entrypoint.sh"]