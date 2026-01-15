pull:
	git pull https://github.com/kluhan/traefik-stack.git

deploy: 
	docker stack deploy -c /opt/stacks/traefik-stack/traefik-stack.yaml traefik

update:
	docker service update --force traefik_traefik