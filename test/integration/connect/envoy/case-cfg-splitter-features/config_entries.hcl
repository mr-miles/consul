config_entries {
  bootstrap {
    kind = "proxy-defaults"
    name = "global"

    config {
      protocol = "http"
    }
  }

  bootstrap {
    kind = "service-resolver"
    name = "s2"

    subsets = {
      "v1" = {
        filter = "Service.Meta.version == v1"
      }

      "v2" = {
        filter = "Service.Meta.version == v2"
      }
    }
  }

  bootstrap {
    kind = "service-splitter"
    name = "s2"

    splits = [
      {
        weight         = 50,
        service_subset = "v2"
      },
      {
        weight         = 50,
        service_subset = "v1"
      },
    ]
  }
}
