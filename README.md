# Example Nomad Pack Registry

This repository is meant to be used as a reference when writing custom pack registries for [Nomad Pack](https://github.com/hashicorp/nomad-pack).

See the [documentation on Writing Packs and Registries](https://github.com/hashicorp/nomad-pack/blob/main/docs/writing-packs.md) for more information.

To get started writing your own pack, make a directory with your pack name. Use the `hello_world` pack as
an example for file structure and contents.

```bash
# Install
curl -L -o /tmp/pack.zip https://github.com/hashicorp/nomad-pack/releases/download/nightly/nomad-pack_0.0.1-techpreview.4_linux_amd64.zip
sudo unzip /tmp/pack.zip -d /usr/local/bin/

# Generate template
nomad-pack generate pack my-pack-name

# Render job to stdout
nomad-pack render nightscout --var datacenters="[\"staging\"]"
```
