# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

app {
  url = "https://nightscout.github.io/"
}

pack {
  name        = "nightscout"
  description = "Deploy Nightscout website (w/optional mongo instance)."
  url         = "https://github.com/hashicorp/example-nomad-pack-registry/nightscout"
  version     = "0.1.0"
}
