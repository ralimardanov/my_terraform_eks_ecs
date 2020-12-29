output "lc_private_key_content" {
  sensitive = true
  value     = join("", tls_private_key.lc_key.*.private_key_pem)
}