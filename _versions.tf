terraform {

  cloud {
    organization = "tarun_org"

    workspaces {
      name = "terraform_module_demo_remote_states"
    }
  }
}