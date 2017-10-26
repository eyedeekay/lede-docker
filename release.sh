#! /usr/bin/env sh

export file_upload="$1"

prerelease(){
        github-release release \
		--user eyedeekay \
		--repo lede-docker \
		--tag $(date +%Y%m%d%H) \
		--name "meshledeconfig" \
		--description "A personal LEDE config with Kadnode and CJDNS pre-installed" \
		--pre-release
}

release_tarball(){
        tar -czf "$file_repo-$(date +%Y%m%d%H%M).tar.gz" "$file_repo"
}

release_images(){
        github-release upload \
                --user eyedeekay \
                --repo lede-docker \
                --tag $(date +%Y%m%d%H) \
                --name "meshledeconfig" \
                --file "$file_upload/bin/targets/ramips"
                mktorrent -a udp://tracker.openbittorrent.com:80 \
                        -a udp://tracker.publicbt.com:80 \
                        -a udp://tracker.opentrackr.org:1337 \
                        -c "A personal LEDE config with Kadnode and CJDNS pre-installed" \
                        -w
}

release_repository(){
        github-release upload \
		--user eyedeekay \
		--repo lede-docker \
		--tag $(date +%Y%m%d%H) \
		--name "meshledeconfig" \
		--file "$file_repo-$(date +%Y%m%d%H%M).tar.gz"
                mktorrent -a udp://tracker.openbittorrent.com:80 \
                        -a udp://tracker.publicbt.com:80 \
                        -a udp://tracker.opentrackr.org:1337 \
                        -c "A personal LEDE config with Kadnode and CJDNS pre-installed" \
                        -w
}


prerelease
release_tarball
release_images
release_repository
