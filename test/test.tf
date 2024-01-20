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
  connection_name = "shark_fin_pastry"
  provider = ssh.ssh_left
  remote = {
    host = "127.0.0.1"
    port = 22
  }
}

data "ssh_tunnel" "docker_right" {
  connection_name = "summers_on_mars"
  provider = ssh.ssh_right
  remote = {
    host = "127.0.0.1"
    port = 22
  }
}
output "left" {
  value = {
    left: {
      id : data.ssh_tunnel.docker_left.id,
      connection_name: data.ssh_tunnel.docker_left.connection_name,
      local_address: {
        host: data.ssh_tunnel.docker_left.local.host
        port: data.ssh_tunnel.docker_left.local.port
      },
      remote_address : {
        host : data.ssh_tunnel.docker_left.remote.host
        port : data.ssh_tunnel.docker_left.remote.port
      },
    }
    right: {
      id : data.ssh_tunnel.docker_right.id,
      connection_name: data.ssh_tunnel.docker_right.connection_name,
      local_address: {
        host: data.ssh_tunnel.docker_right.local.host
        port: data.ssh_tunnel.docker_right.local.port
      },
      remote_address : {
        host : data.ssh_tunnel.docker_right.remote.host
        port : data.ssh_tunnel.docker_right.remote.port
      },
    },
  }
}