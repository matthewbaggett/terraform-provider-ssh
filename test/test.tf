provider "ssh" {
  alias = "left"
  server = {
    host = "127.0.0.1"
    port = "22"
  }
  user = "matthew"
  auth = {
    private_key = {
      content = file("~/.ssh/id_rsa")
    }
  }
}

provider "ssh" {
  alias = "right"
  server = {
    host = "127.0.0.1"
    port = "22"
  }
  user = "matthew"
  auth = {
    private_key = {
      content = file("~/.ssh/id_rsa")
    }
  }
}
data "ssh_tunnel" "docker_left" {
  connection_name = "left"
  provider = ssh.left
  remote = {
    socket = "/var/run/docker.sock"
  }
}
data "ssh_tunnel" "docker_right" {
  connection_name = "left"
  provider = ssh.right
  remote = {
    socket = "/var/run/docker.sock"
  }
}