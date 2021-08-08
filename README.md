<!-- BEGIN_TF_DOCS -->
[![Tests](https://github.com/netascode/terraform-aci-inband-endpoint-group/actions/workflows/test.yml/badge.svg)](https://github.com/netascode/terraform-aci-inband-endpoint-group/actions/workflows/test.yml)

# Terraform ACI Inband Endpoint Group Module

Manages ACI Inband Endpoint Group

Location in GUI:
`Tenants` » `mgmt` » `Node Management EPGs`

## Examples

```hcl
module "aci_inband_endpoint_group" {
  source = "netascode/inband-endpoint-group/aci"

  name          = "INB1"
  vlan          = 10
  bridge_domain = "INB1"
  contracts = {
    providers          = ["CON1"]
    consumers          = ["CON1"]
    imported_consumers = ["I-CON1"]
  }
}

```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_aci"></a> [aci](#requirement\_aci) | >= 0.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aci"></a> [aci](#provider\_aci) | >= 0.2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Inband endpoint group name. | `string` | n/a | yes |
| <a name="input_vlan"></a> [vlan](#input\_vlan) | Vlan ID. Minimum value: 1. Maximum value: 4096. | `number` | n/a | yes |
| <a name="input_bridge_domain"></a> [bridge\_domain](#input\_bridge\_domain) | Bridge domain name. | `string` | n/a | yes |
| <a name="input_contracts"></a> [contracts](#input\_contracts) | Contracts. | <pre>object({<br>    consumers          = optional(list(string))<br>    providers          = optional(list(string))<br>    imported_consumers = optional(list(string))<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dn"></a> [dn](#output\_dn) | Distinguished name of `mgmtInB` object. |
| <a name="output_name"></a> [name](#output\_name) | Inband endpoint group name. |

## Resources

| Name | Type |
|------|------|
| [aci_rest.fvRsCons](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.fvRsConsIf](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.fvRsProv](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.mgmtInB](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
| [aci_rest.mgmtRsMgmtBD](https://registry.terraform.io/providers/netascode/aci/latest/docs/resources/rest) | resource |
<!-- END_TF_DOCS -->