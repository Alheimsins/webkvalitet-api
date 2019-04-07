workflow "Rebuild every day" {
  resolves = ["Alias deployment"]
  on = "push"
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

action "Deploy to now" {
  uses = "actions/zeit-now@666edee2f3632660e9829cb6801ee5b7d47b303d"
  args = "--team alheimsins"
  secrets = ["ZEIT_TOKEN"]
  needs = ["Build partier"]
}

action "Alias deployment" {
  uses = "actions/zeit-now@666edee2f3632660e9829cb6801ee5b7d47b303d"
  needs = ["Deploy to now"]
  args = "alias --team alheimsins"
  secrets = ["ZEIT_TOKEN"]
}
