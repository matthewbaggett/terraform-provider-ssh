provider "ssh" {
  alias = "ssh_left"
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
  alias = "ssh_right"
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
  connection_name = "1234"
  provider = ssh.ssh_left
  remote = {
    host = "127.0.0.1"
    port = 22
  }
}

data "ssh_tunnel" "docker_right" {
  connection_name = "4321"
  provider = ssh.ssh_right
  remote = {
    host = "127.0.0.1"
    port = 22
  }
}