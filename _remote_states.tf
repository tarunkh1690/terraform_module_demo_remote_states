data "terraform_remote_state" "terraform_module_demo_publicmodule" {
    backend = "remote"

    config = {
        hostname = "app.terraform.io"
        organization = "tarun_org"
        workspaces = {
          name = "terraform_module_demo_publicmodule"
        }
    }
}