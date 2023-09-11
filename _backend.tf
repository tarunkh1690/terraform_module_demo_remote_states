terraform {
  required_version = "1.0.11"

  backend "remote" {
    organization = "tarun_org"

    workspaces {
      name = "terraform_module_demo_remote_states"
    }
  }
}
