#! /usr/bin/env sh

file_upload="$1"

echo "$file_upload"

delrelease(){
        github-release delete \
		--user eyedeekay \
		--repo lede-docker \
		--tag $(date +%Y%m%d%H)
}

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
        tar -czf "$file_upload-$(date +%Y%m%d%H).tar.gz" "$file_upload/packages/"
}

release_images(){
        github-release upload \
                --user eyedeekay \
                --repo lede-docker \
                --tag $(date +%Y%m%d%H) \
                --name "$(basename $(find $file_upload/targets -name *.bin))" \
                --file "$(find $file_upload/targets -name *.bin)"
}

release_repository(){
        github-release upload \
		--user eyedeekay \
		--repo lede-docker \
		--tag $(date +%Y%m%d%H) \
		--name "$file_upload-$(date +%Y%m%d%H).tar.gz" \
		--file "$file_upload-$(date +%Y%m%d%H).tar.gz"
}

release_torrent_image(){
        mktorrent -a udp://tracker.openbittorrent.com:80 \
                        -a udp://tracker.publicbt.com:80 \
                        -a udp://tracker.opentrackr.org:1337 \
                        -c "A personal LEDE config with Kadnode and CJDNS pre-installed" \
                        -w "https://github.com/eyedeekay/lede-docker/releases/download/$(date +%Y%m%d%H)/$(basename $(find $file_upload/targets -name *.bin))" \
                        "$(find $file_upload/targets -name *.bin)"
}

release_torrent_repository(){
        mktorrent -a udp://tracker.openbittorrent.com:80 \
                        -a udp://tracker.publicbt.com:80 \
                        -a udp://tracker.opentrackr.org:1337 \
                        -c "A personal LEDE config with Kadnode and CJDNS pre-installed" \
                        -w "https://github.com/eyedeekay/lede-docker/releases/download/$(date +%Y%m%d%H)/$file_upload-$(date +%Y%m%d%H).tar.gz" \
                        "$file_upload-$(date +%Y%m%d%H).tar.gz"
}

release_torrents(){
        for f in *.torrent; do
                github-release upload \
		--user eyedeekay \
		--repo lede-docker \
		--tag $(date +%Y%m%d%H) \
		--name "$f" \
		--file "$f"
        done
}

delrelease
prerelease
release_tarball "$file_upload"
release_repository "$file_upload"
release_torrent_repository "$file_upload"
release_images "$file_upload"
release_torrent_image "$file_upload"
release_torrents
#



