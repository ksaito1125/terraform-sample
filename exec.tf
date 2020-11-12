resource "null_resource" "git-source" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = "echo $(git remote get-url origin)@$(git rev-parse --abbrev-ref HEAD) > sample.txt"
  }
}
data "local_file" "git-source-file" {
  filename = "${path.module}/sample.txt"
  depends_on = [null_resource.git-source]
}
locals {
  git_source = data.local_file.git-source-file.content
}
output "source" {
  value = local.git_source
}
