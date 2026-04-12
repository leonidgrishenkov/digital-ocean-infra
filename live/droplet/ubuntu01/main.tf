resource "random_password" "passwd" {
  length  = 30
  upper   = true
  lower   = true
  numeric = true
  special = true
}

resource "tls_private_key" "ssh_key" {
  algorithm = "ED25519"
  rsa_bits  = 4096
}
# Register SSH public key in DigitalOcean
resource "digitalocean_ssh_key" "main" {
  name       = "${var.name}-${var.user}" # what's that actualy is?
  public_key = tls_private_key.ssh_key.public_key_openssh
}

resource "local_file" "private_ssh_key" {
  content         = tls_private_key.ssh_key.private_key_openssh
  filename        = pathexpand("~/.ssh/keys/digital-ocean/droplet/${var.name}/${var.user}")
  file_permission = "0600"
}

resource "local_file" "public_ssh_key" {
  content         = tls_private_key.ssh_key.public_key_openssh
  filename        = pathexpand("~/.ssh/keys/digital-ocean/droplet/${var.name}/${var.user}.pub")
  file_permission = "0644"
}

resource "digitalocean_droplet" "droplet" {
  image    = "ubuntu-22-04-x64"
  name     = var.name
  region   = "ams3"
  size     = "s-1vcpu-1gb"
  backups  = false
  tags     = ["dev", "iac"]
  ssh_keys = [digitalocean_ssh_key.main.fingerprint]

  user_data = templatefile(
    "${path.module}/cloud-init.yaml",
    {
      user_name    = var.user
      user_passwd  = random_password.passwd.bcrypt_hash
      user_ssh_key = tls_private_key.ssh_key.public_key_openssh
    }
  )
}
