
new:
	make docker-parent-build

docker-all:
	make docker-parent-build
	make docker-build

docker-parent-build:
	docker rm -f lede-docker; \
	docker build --force-rm --build-arg "CACHING_PROXY=$(proxy_addr)" -t lede-docker .

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

build: omega2 mtseeed wndr3800
	docker run -i --privileged --name lede-build -t lede-build
	make copy-bin
	make archive

omega2:
	docker build --force-rm -f Dockerfile.omega2 -t lede-build-omega2 .
	docker run --name lede-build-omega2 -t lede-build-omega2 bash
	docker cp lede-build-omega2:/home/lede-build/source/bin ./bin-omega2
	docker rm -f lede-build-omega2; \
	docker rmi -f lede-build-omega2; \
	docker system prune -f; true

mtseeed:
	docker build --force-rm -f Dockerfile.mtseeed -t lede-build-mtseeed .
	docker run --name lede-build-mtseeed -t lede-build-mtseeed bash
	docker cp lede-build-mtseeed:/home/lede-build/source/bin ./bin-mtseeed
	docker rm -f lede-build-mtseeed; \
	docker rmi -f lede-build-mtseeed; \
	docker system prune -f; true

wndr3800:
	docker build --force-rm -f Dockerfile.wndr3800 -t lede-build-wndr3800 .
	docker run --name lede-build-wndr3800 -t lede-build-wndr3800 bash
	docker cp lede-build-wndr3800:/home/lede-build/source/bin ./bin-wndr3800
	docker rm -f lede-build-wndr3800; \
	docker rmi -f lede-build-wndr3800; \
	docker system prune -f; true


old-build:
	docker run -i --privileged --name lede-build -t lede-build
	make copy-bin
	make archive

archive:
	rm -rf $(HOME)/Builds/lede-$(shell date -d "yesterday" +%Y%m%d)*
	cp -Rv bin* "$(HOME)/Builds/lede-$(shell date +%Y%m%d%I)"

copy-config:
	docker cp lede-build:/home/lede-build/source/.config .config.in

copy-bin:
	rm -rf bin
	docker cp lede-build:/home/lede-build/source/bin .

untar:
	rm -rf files && mkdir files
	cd files && tar -xvf ../*.tar

clobber:
	docker rm -f lede-docker lede-build lede-config lede-test lede-kernel-config; \
	docker rmi -f lede-docker lede-build lede-config lede-test lede-kernel-config

release:
	@echo "don't use this yet."
	#./release.sh
