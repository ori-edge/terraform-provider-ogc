---
# generated by https://github.com/hashicorp/terraform-plugin-docs
page_title: "ogc_container Resource - ogc"
subcategory: ""
description: |-
  A Container entity encapsulates all the information required to run an OCI-compliant container image.
---

# ogc_container (Resource)

A Container entity encapsulates all the information required to run an OCI-compliant container image.

## Example Usage

```terraform
resource "ogc_container" "container" {
  name = "example"
  application_id = ogc_application.app.id
  image = "nginx"
  env {
    name = "PORT"
    value = "80"
  }
}
```

<!-- schema generated by tfplugindocs -->
## Schema

### Required

- `application_id` (String) The id of the parent Application of the Container.
- `image` (String) The name of the OCI container image in the associated ImageRegistry.

### Optional

- `args` (String) The arguments to pass to the command to execute in the Container as a single string to be tokenised at deployment.
- `command` (String) The command to execute in the Container.
- `display_name` (String) The user-supplied name of the Container.
- `env` (Block List) List of environment variables to set in the container as key/value pairs. (see [below for nested schema](#nestedblock--env))
- `image_credentials_name` (String) Name of the BasicAuth credentials if image is not publicly accessible.
- `name` (String) The user-supplied RFC 1123-compliant name of the Container.
- `privileged_access` (Boolean) If true the container will be deployed in privileged access mode. Cannot be true if the owning Application's rejectPrivilegedClusters property is true or the owning Project's permitPrivilegedContainers property is false.

### Read-Only

- `id` (String) The unique identifier of the Container.
- `last_updated` (String) The timestamp of the last change to this entity and any sub-entities.

<a id="nestedblock--env"></a>
### Nested Schema for `env`

Required:

- `name` (String) Name of the environment variable.

Optional:

- `secret_name` (String) Secret to be used as value for the environment variable.
- `value` (String) Value of the environment variable.
