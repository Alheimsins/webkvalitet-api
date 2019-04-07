workflow "Rebuild every day" {
  resolves = ["Alias deployment"]
  on = "push"
}

action "Build partier" {
  uses = "actions/npm@59b64a598378f31e49cb76f27d6f3312b582f680"
  args = "run build-partier"
}

action "Deploy to now" {
  uses = "actions/zeit-now@666edee2f3632660e9829cb6801ee5b7d47b303d"
  needs = ["Build partier"]
  args = "--team alheimsins"
  secrets = ["ZEIT_TOKEN"]
}

action "Alias deployment" {
  uses = "actions/zeit-now@666edee2f3632660e9829cb6801ee5b7d47b303d"
  needs = ["Deploy to now"]
  args = "alias --team alheimsins"
}
