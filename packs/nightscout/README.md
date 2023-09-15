# nightscout

<!-- Include a brief description of your pack -->

This pack deploys a Nightscout website. By default it will also deploy a local mongo instance for persisting/storing data.

## Pack Usage

```bash
# Install nomad-pack
curl -L -o /tmp/pack.zip https://github.com/hashicorp/nomad-pack/releases/download/nightly/nomad-pack_0.0.1-techpreview.4_linux_amd64.zip
sudo unzip /tmp/pack.zip -d /usr/local/bin/
```

```bash
# Render job to stdout
nomad-pack render nightscout --var datacenters="[\"staging\"]"

# Deploy to Nomad
export NOMAD_ADDR=http://127.0.0.1:4646
nomad-pack plan nightscout --var datacenters="[\"staging\"]"
nomad-pack run nightscout --var datacenters="[\"staging\"]"

# Check job status
nomad-pack status nightscout
```

### Consul Service and Load Balancer Integration

Optionally, it can configure a Consul service.

If the `register_consul_service` is unset or set to true, the Consul service
will be registered.

Several load balancers in the [Nomad Pack Community Registry][pack-registry]
are configured to connect to this service by default.

The [Traefik][pack-traefik] packs are configured to
search for Consul services with the tags found in the default value of the
`consul_service_tags` variable.

## Variables

<!-- Include information on the variables from your pack -->

- `job_name` (string) - The name to use as the job name which overrides using
  the pack name
- `count` (number) - The number of app instances to deploy
- `datacenters` (list of strings) - A list of datacenters in the region which
  are eligible for task placement
- `region` (string) - The region where jobs will be deployed
- `register_consul_service` (bool) - If you want to register a consul service
  for the job
- `consul_service_tags` (list of string) - The consul service name for the
  nightscout application
- `consul_service_name` (string) - The consul service name for the nightscout
  application

## Other

[pack-registry]: https://github.com/hashicorp/nomad-pack-community-registry
[pack-traefik]: https://github.com/hashicorp/nomad-pack-community-registry/tree/main/packs/traefik/traefik/README.md
