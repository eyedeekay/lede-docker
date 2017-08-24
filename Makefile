
docker-all:
	make docker-parent-build
	make docker-build

docker-parent-build:
	docker build -t lede-docker .

docker-build:
	docker build -f Dockerfile.build -t lede-build .

docker-test:
	docker build -f Dockerfile.build -t lede-test .

run:
	docker run -i --rm --name lede-build -t lede-build bash

copy-config:
	docker cp lede-build:/home/lede-build/source/.config .

untar:
	rm -rf files && mkdir files
	cd files && tar -xvf ../*.tar
