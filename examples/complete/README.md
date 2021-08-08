<!-- BEGIN_TF_DOCS -->
# Inband Endpoint Group Example

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example will create resources. Resources can be destroyed with `terraform destroy`.

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
<!-- END_TF_DOCS -->