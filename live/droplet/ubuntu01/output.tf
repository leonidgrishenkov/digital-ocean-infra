output "passwd" {
  value     = random_password.passwd.result
  sensitive = true
  description = "Main user's password"
}

output "ssh_private_key" {
  value       = tls_private_key.ssh_key.private_key_openssh
  sensitive   = true
  description = "Main user's ssh key"
}

output "ssh_public_key" {
  value       = tls_private_key.ssh_key.public_key_openssh
  description = "Main user's ssh public key"
}

 output "droplet_ip" {
    value       = digitalocean_droplet.droplet.ipv4_address
    description = "Droplet public IP address"
  }
