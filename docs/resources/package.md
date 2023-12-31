---
# generated by https://github.com/hashicorp/terraform-plugin-docs
page_title: "ogc_package Resource - ogc"
subcategory: ""
description: |-
  Packages are the smallest deployable unit in OGC. Packages can have one or more applications that can be connected between themselves through route policies. Applications within a single package may be deployed across multiple clusters. Package selectors decide which clusters will be selected during deployment planning.
---

# ogc_package (Resource)

Packages are the smallest deployable unit in OGC. Packages can have one or more applications that can be connected between themselves through route policies. Applications within a single package may be deployed across multiple clusters. Package selectors decide which clusters will be selected during deployment planning.

## Example Usage

```terraform
resource "ogc_package" "pkg" {
  name = "example"
  project_id = "0e145a36-1ee7-434c-9f30-9e1ba4da2d7c"
}
```

<!-- schema generated by tfplugindocs -->
## Schema

### Required

- `project_id` (String) The id of the parent Project.

### Optional

- `display_name` (String) The user-supplied name of the Package.
- `name` (String) The user-supplied RFC 1123-compliant name of the Package.
- `selector` (Block List) A Package may have zero or more Selectors associated with it. These Selectors apply to all Applications in the Package during deployment planning. (see [below for nested schema](#nestedblock--selector))

### Read-Only

- `id` (String) The unique identifier of the Package.
- `last_updated` (String) The timestamp of the last change to this entity and any sub-entities.

<a id="nestedblock--selector"></a>
### Nested Schema for `selector`

Required:

- `key` (String) The key that is used to match the key property of a Label.

Optional:

- `operator` (String) The SelectorOp used as part of the label matching operation. Can be one of: Exists, NotExists, Equals, NotEquals, In, NotIn, MinOf, MaxOf. Defaults to In.
- `values` (List of String) The values to be used during deployment planning. If operator is Exists, NotExists, MinOf or MaxOf this should be empty.

Read-Only:

- `id` (String) The unique identifier of the Selector.
