workflow "Updates partier and fylker" {
  resolves = ["Auto-commit"]
  on = "schedule(0 0 * * *)"
}

action "Install dependencies" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  args = "install"
}

action "Build partier" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  args = "run build-partier"
  needs = ["Install dependencies"]
}

action "Build fylker" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  args = "run build-fylker"
  needs = ["Build partier"]
}

action "Deploy to now" {
  uses = "actions/zeit-now@666edee2f3632660e9829cb6801ee5b7d47b303d"
  args = "--team alheimsins"
  secrets = ["ZEIT_TOKEN"]
  needs = ["Build fylker"]
}

action "Alias deployment" {
  uses = "actions/zeit-now@666edee2f3632660e9829cb6801ee5b7d47b303d"
  needs = ["Deploy to now"]
  args = "alias --team alheimsins"
  secrets = ["ZEIT_TOKEN"]
}

action "Auto-commit" {
  uses = "docker://cdssnc/auto-commit-github-action"
  needs = ["Alias deployment"]
  args = "Data updated"
  secrets = ["GITHUB_TOKEN"]
}

# Flow for direktorater

workflow "Updates direktorater" {
  resolves = ["Auto-commit direktorater"]
  on = "schedule(0 1 * * *)"
}

action "Install dependencies" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  args = "install"
}

action "Build direktorater" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  args = "run build-direktorater"
  needs = ["Install dependencies"]
}

action "Deploy to now" {
  uses = "actions/zeit-now@666edee2f3632660e9829cb6801ee5b7d47b303d"
  args = "--team alheimsins"
  secrets = ["ZEIT_TOKEN"]
  needs = ["Build direktorater"]
}

action "Alias deployment" {
  uses = "actions/zeit-now@666edee2f3632660e9829cb6801ee5b7d47b303d"
  needs = ["Deploy to now"]
  args = "alias --team alheimsins"
  secrets = ["ZEIT_TOKEN"]
}

action "Auto-commit direktorater" {
  uses = "docker://cdssnc/auto-commit-github-action"
  needs = ["Alias deployment"]
  args = "Data updated"
  secrets = ["GITHUB_TOKEN"]
}