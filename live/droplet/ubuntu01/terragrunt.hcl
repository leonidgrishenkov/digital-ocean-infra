include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "."
}

inputs = {
  name               = "ubuntu01"
  user               = "main"
  tailscale_auth_key = get_env("TAILSCALE_AUTH_KEY")
}

