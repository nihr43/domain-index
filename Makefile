push: image
	docker push images.local:30500/domain-index

image:
	docker build . --tag=images.local:30500/domain-index
