---
# generated by https://github.com/hashicorp/terraform-plugin-docs
page_title: "ogc_project Resource - ogc"
subcategory: ""
description: |-
  A project where application are configured.
---

# ogc_project (Resource)

A project where application are configured.

## Example Usage

```terraform
resource ogc_project proj {
  name = "project"
}
```

<!-- schema generated by tfplugindocs -->
## Schema

### Required

- `name` (String) The user-supplied RFC 1123-compliant name of the Project.

### Read-Only

- `display_name` (String) The user-supplied name of the Project.
- `id` (String) The unique identifier of the Project.
- `organisation_id` (String) The id of the parent Organisation.
- `updated_at` (String) The timestamp of Project last update.