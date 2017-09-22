
new:
	make docker-parent-build

docker-all:
	make docker-parent-build
	make docker-build

docker-parent-build:
	docker rm -f lede-docker; \
	docker build --force-rm -t lede-docker .

docker-build:
	docker rm -f lede-build; \
	docker build --force-rm -f Dockerfile.build -t lede-build .

docker-test:
	docker build -f Dockerfile.build -t lede-test .

menuconfig:
	docker run -i --name lede-config -t lede-docker make menuconfig
	docker cp lede-config:/home/lede-build/source/.config .config.in
	docker rm -f lede-config

editconfig:
	docker run -i --name lede-config -t lede-build make menuconfig
	docker cp lede-config:/home/lede-build/source/.config .config.in
	docker rm -f lede-config

diffconfig:
	docker run --name lede-config -t lede-build ./scripts/diffconfig.sh > config.diff.in

kadnode:
	docker rm -f lede-kadnode; \
	docker run -i --name lede-kadnode -t lede-docker make package/kadnode/compile V=s
	#docker cp lede-kadnode:/home/lede-build/source/package/kadnode

yesconfig:
	docker run -i --name lede-allyes-config -t lede-docker make allyesconfig
	docker cp lede-config:/home/lede-build/source/.config .allyesconfig
	docker rm -f lede-allyes-config

kernel_menuconfig:
	docker run -i --name lede-kernel-config -t lede-docker make kernel_menuconfig
	docker cp lede-kernel-config:/home/lede-build/source/.config .config.k.in
	docker rm -f lede-kernel-config

savenv:
	docker save lede-docker -o lede-docker.tar

snapshot:
	docker save lede-build -o lede-build.tar

split:
	split -b 99M lede-docker.tar
	split -b 99M lede-build.tar

build:
	docker run -i --name lede-build -t lede-build
	make copy-bin

copy-config:
	docker cp lede-build:/home/lede-build/source/.config .config.in

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

