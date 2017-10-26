#! /usr/bin/env sh

file_upload="$1"

echo "$file_upload"

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
        tar -czf "$file_upload-$(date +%Y%m%d%H%M).tar.gz" "$file_upload/packages/"
}

release_images(){
        github-release upload \
                --user eyedeekay \
                --repo lede-docker \
                --tag $(date +%Y%m%d%H) \
                --name "meshledeconfig" \
                --file "$file_upload/bin/targets/ramips/mt7688/lede-ramips-mt7688-omega2p-squashfs-sysupgrade.bin"

}

release_repository(){
        github-release upload \
		--user eyedeekay \
		--repo lede-docker \
		--tag $(date +%Y%m%d%H) \
		--name "meshledeconfig" \
		--file "$file_upload-$(date +%Y%m%d%H%M).tar.gz"
}

release_torrent_image(){
        mktorrent -a udp://tracker.openbittorrent.com:80 \
                        -a udp://tracker.publicbt.com:80 \
                        -a udp://tracker.opentrackr.org:1337 \
                        -c "A personal LEDE config with Kadnode and CJDNS pre-installed" \
                        -w
                        "$file_upload/bin/targets/ramips/mt7688/lede-ramips-mt7688-omega2p-squashfs-sysupgrade.bin"
}

release_torrent_repository(){
        mktorrent -a udp://tracker.openbittorrent.com:80 \
                        -a udp://tracker.publicbt.com:80 \
                        -a udp://tracker.opentrackr.org:1337 \
                        -c "A personal LEDE config with Kadnode and CJDNS pre-installed" \
                        -w
}

prerelease
release_tarball "$file_upload"
release_repository "$file_upload"
release_images "$file_upload"
#release_torrent_image "$file_upload"
#


