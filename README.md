Traefik Stack
===============

Minimal Docker Swarm stack to run Traefik (v3.1) with ACME via Cloudflare DNS-01.

Files
- [traefik-stack.yaml](traefik-stack.yaml) – stack definition (services, volumes, secrets, network).

Requirements
- Docker Engine with Swarm mode enabled
- An external overlay network named `traefik-public`
- Two Docker secrets:
  - `cloudflare_dns_api_token` (Cloudflare API token)
  - `letsencrypt_contact_email` (Let's Encrypt contact email)

Quick setup

1. Create the external network (if it doesn't already exist):

```bash
docker network create --driver overlay traefik-public
```

2. Create the required secrets (example):

```bash
# Cloudflare token from a file
docker secret create cloudflare_dns_api_token /path/to/cloudflare.token

# Email (pipe from echo to create secret from stdin)
printf "%s" "you@example.com" | docker secret create letsencrypt_contact_email -

```

3. Deploy the stack:

```bash
docker stack deploy -c traefik-stack.yaml traefik
```

Notes
- Traefik stores ACME data in the `traefik-acme` volume mounted at `/acme` inside the container.
- The stack expects the `traefik-public` network to be created externally (not defined as internal in the compose file).
- The Traefik dashboard is enabled (`--api.dashboard=true`) — ensure it is protected and not exposed publicly.
- Adjust placement constraints in `traefik-stack.yaml` if you need the service on a specific manager node.
- Make sure to configure your DNS records in Cloudflare to point to your Traefik instance for the domains you want to manage.
