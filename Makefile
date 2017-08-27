
docker-all:
	make docker-parent-build

docker-parent-build:
	docker build -t lede-docker .

docker-build:
	docker rm -f lede-build; \
	docker build -f Dockerfile.build -t lede-docker .
	make run

docker-test:
	docker build -f Dockerfile.build -t lede-test .

menuconfig:
	docker run -i --name lede-config -t lede-docker make menuconfig
	docker cp lede-config:/home/lede-build/source/.config .
	docker rm -f lede-config

kernel_menuconfig:
	docker run -i --name lede-kernel-config -t lede-docker make kernel_menuconfig
	docker cp lede-kernel-config:/home/lede-build/source/.config .
	docker rm -f lede-kernel-config

run:
	docker run -i --name lede-build -t lede-build

copy-config:
	docker cp lede-config:/home/lede-build/source/.config .

copy-bin:
	docker cp lede-build:/home/lede-build/source/bin .

untar:
	rm -rf files && mkdir files
	cd files && tar -xvf ../*.tar
