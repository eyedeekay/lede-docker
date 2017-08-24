
docker-all:
	make docker-parent-build
	make docker-build

docker-parent-build:
	docker build -t lede-docker .

docker-build:
	docker build -f Dockerfile.build -t lede-build .

docker-test:
	docker build -f Dockerfile.build -t lede-test .

docker-config:
	docker run -i --rm --name lede-config -t lede-build bash -c "make nconfig && bash"
	docker stop lede-config

docker-kernel_config:
	docker run -i --rm --name lede-kernel-config -t lede-build bash -c "make kernel_menuconfig && bash"
	docker stop lede-kernel-config

run:
	docker run -i --rm --name lede-build -t lede-build make

copy-config:
	docker cp lede-build:/home/lede-build/source/.config .

untar:
	rm -rf files && mkdir files
	cd files && tar -xvf ../*.tar
