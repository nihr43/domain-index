push: image
	docker push images.local:5000/domain-index

image:
	docker build . --tag=images.local:5000/domain-index
