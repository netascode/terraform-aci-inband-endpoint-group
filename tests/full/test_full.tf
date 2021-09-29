terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }

    aci = {
      source  = "netascode/aci"
      version = ">=0.2.0"
    }
  }
}

module "main" {
  source = "../.."

  name                        = "INB1"
  vlan                        = 10
  bridge_domain               = "INB1"
  contract_consumers          = ["CON1"]
  contract_providers          = ["CON1"]
  contract_imported_consumers = ["I_CON1"]
}

data "aci_rest" "mgmtInB" {
  dn = "uni/tn-mgmt/mgmtp-default/inb-${module.main.name}"

  depends_on = [module.main]
}

resource "test_assertions" "mgmtInB" {
  component = "mgmtInB"

  equal "name" {
    description = "name"
    got         = data.aci_rest.mgmtInB.content.name
    want        = module.main.name
  }

  equal "encap" {
    description = "encap"
    got         = data.aci_rest.mgmtInB.content.encap
    want        = "vlan-10"
  }
}

data "aci_rest" "mgmtRsMgmtBD" {
  dn = "${data.aci_rest.mgmtInB.id}/rsmgmtBD"

  depends_on = [module.main]
}

resource "test_assertions" "mgmtRsMgmtBD" {
  component = "mgmtRsMgmtBD"

  equal "tnFvBDName" {
    description = "tnFvBDName"
    got         = data.aci_rest.mgmtRsMgmtBD.content.tnFvBDName
    want        = "INB1"
  }
}

data "aci_rest" "fvRsProv" {
  dn = "${data.aci_rest.mgmtInB.id}/rsprov-CON1"

  depends_on = [module.main]
}

resource "test_assertions" "fvRsProv" {
  component = "fvRsProv"

  equal "tnVzBrCPName" {
    description = "tnVzBrCPName"
    got         = data.aci_rest.fvRsProv.content.tnVzBrCPName
    want        = "CON1"
  }
}

data "aci_rest" "fvRsCons" {
  dn = "${data.aci_rest.mgmtInB.id}/rscons-CON1"

  depends_on = [module.main]
}

resource "test_assertions" "fvRsCons" {
  component = "fvRsCons"

  equal "tnVzBrCPName" {
    description = "tnVzBrCPName"
    got         = data.aci_rest.fvRsCons.content.tnVzBrCPName
    want        = "CON1"
  }
}

data "aci_rest" "fvRsConsIf" {
  dn = "${data.aci_rest.mgmtInB.id}/rsconsIf-I_CON1"

  depends_on = [module.main]
}

resource "test_assertions" "fvRsConsIf" {
  component = "fvRsConsIf"

  equal "tnVzCPIfName" {
    description = "tnVzCPIfName"
    got         = data.aci_rest.fvRsConsIf.content.tnVzCPIfName
    want        = "I_CON1"
  }
}
