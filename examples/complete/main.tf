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
