---
# generated by https://github.com/hashicorp/terraform-plugin-docs
page_title: "ogc Provider"
subcategory: ""
description: |-
  
---

# ogc Provider



## Example Usage

```terraform
terraform {
  required_providers {
    ogc = {
      source  = "hashicorp.com/dev/ogc"
    }
  }
}

provider "ogc" {
}
```

<!-- schema generated by tfplugindocs -->
## Schema

### Optional

- `access_token` (String, Sensitive) Access token used to interact with Ori Global Cloud. Can be provided via OGC_ACCESS_TOKEN environment variable.
