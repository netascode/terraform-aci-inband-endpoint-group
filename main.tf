resource "aci_rest" "mgmtInB" {
  dn         = "uni/tn-mgmt/mgmtp-default/inb-${var.name}"
  class_name = "mgmtInB"
  content = {
    name  = var.name
    encap = "vlan-${var.vlan}"
  }
}

resource "aci_rest" "fvRsProv" {
  for_each   = toset(var.contract_providers)
  dn         = "${aci_rest.mgmtInB.dn}/rsprov-${each.value}"
  class_name = "fvRsProv"
  content = {
    tnVzBrCPName = each.value
  }
}

resource "aci_rest" "fvRsCons" {
  for_each   = toset(var.contract_consumers)
  dn         = "${aci_rest.mgmtInB.dn}/rscons-${each.value}"
  class_name = "fvRsCons"
  content = {
    tnVzBrCPName = each.value
  }
}

resource "aci_rest" "fvRsConsIf" {
  for_each   = toset(var.contract_imported_consumers)
  dn         = "${aci_rest.mgmtInB.dn}/rsconsIf-${each.value}"
  class_name = "fvRsConsIf"
  content = {
    tnVzCPIfName = each.value
  }
}

resource "aci_rest" "mgmtRsMgmtBD" {
  dn         = "${aci_rest.mgmtInB.dn}/rsmgmtBD"
  class_name = "mgmtRsMgmtBD"
  content = {
    tnFvBDName = var.bridge_domain
  }
}
