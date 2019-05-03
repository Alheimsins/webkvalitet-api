# Commit changes

Commit changes from workflow back to master

```
action "Commit changes" {
  uses = "./github-action/commit-changes"
  needs = ["Alias deployment"]
  args = "Data updated (ignore)"
  secrets = ["GITHUB_TOKEN"]
}
```
