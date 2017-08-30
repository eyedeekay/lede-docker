
docker-all:
	make docker-parent-build
	make docker-build

docker-parent-build:
	docker build --force-rm -t lede-docker .

docker-build:
	docker rm -f lede-build; \
	docker build --force-rm -f Dockerfile.build -t lede-build .

docker-test:
	docker build -f Dockerfile.build -t lede-test .

menuconfig:
	docker run -i --name lede-config -t lede-docker make menuconfig
	docker cp lede-config:/home/lede-build/source/.config .
	docker rm -f lede-config

yesconfig:
	docker run -i --name lede-allyes-config -t lede-docker make allyesconfig
	docker cp lede-config:/home/lede-build/source/.config .allyesconfig
	docker rm -f lede-allyes-config

kernel_menuconfig:
	docker run -i --name lede-kernel-config -t lede-docker make kernel_menuconfig
	docker cp lede-kernel-config:/home/lede-build/source/.config .
	docker rm -f lede-kernel-config

build:
	docker run -i --name lede-build -t lede-build

copy-config:
	docker cp lede-config:/home/lede-build/source/.config .

copy-bin:
	rm -rf bin
	docker cp lede-build:/home/lede-build/source/bin .

untar:
	rm -rf files && mkdir files
	cd files && tar -xvf ../*.tar

clobber:
	docker rm -f lede-docker lede-build lede-config lede-test lede-kernel-config

release:
	@echo "don't use this yet."
	#./release.sh

