output "dn" {
  value       = aci_rest.mgmtInB.id
  description = "Distinguished name of `mgmtInB` object."
}

output "name" {
  value       = aci_rest.mgmtInB.content.name
  description = "Inband endpoint group name."
}
