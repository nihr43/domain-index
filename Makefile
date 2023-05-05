push: image
	docker push images.local:30500/domain-index

image:
	docker build . --tag=images.local:30500/domain-index

jenkins:
	docker build --no-cache . --tag=images.local:30500/domain-index
	docker push images.local:30500/domain-index
