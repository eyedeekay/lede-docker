#! /usr/bin/env sh

export PATH="$HOME/.go/bin/:$PATH"

file_upload="$1"

version_tag="17.01.04"
release_tag="e_wrt"

delrelease(){
        github-release delete \
		--user eyedeekay \
		--repo lede-docker \
		--tag "$version_tag"
}

prerelease(){
        github-release release \
		--user eyedeekay \
		--repo lede-docker \
		--tag "$version_tag" \
		--name "$release_tag" \
		--description "A personal LEDE config with Kadnode and CJDNS pre-installed" \
		--pre-release
}

release_tarball(){
        tar -czf "$file_upload-$version_tag.tar.gz" "$file_upload/packages/"
}

release_images(){
        for f in $(find "$file_upload"/targets -name *.bin); do
                echo "$f"
                github-release upload \
                        --user eyedeekay \
                        --repo lede-docker \
                        --tag "$version_tag" \
                        --name "$(basename $f)" \
                        --file "$f"
        done
}

release_repository(){
        github-release upload \
		--user eyedeekay \
		--repo lede-docker \
		--tag "$version_tag" \
		--name "$file_upload-$version_tag.tar.gz" \
		--file "$file_upload-$version_tag.tar.gz"
}

release_torrent_image(){
        for f in $(find "$file_upload"/targets -name *.bin); do
                echo "$f"
                mktorrent -a udp://tracker.openbittorrent.com:80 \
                                -a udp://tracker.publicbt.com:80 \
                                -a udp://tracker.opentrackr.org:1337 \
                                -c "A personal LEDE config with Kadnode and CJDNS pre-installed" \
                                -w "https://github.com/eyedeekay/lede-docker/releases/download/$version_tag/$(basename $f)" \
                                "$f"
        done
}

release_torrent_repository(){
        mktorrent -a udp://tracker.openbittorrent.com:80 \
                        -a udp://tracker.publicbt.com:80 \
                        -a udp://tracker.opentrackr.org:1337 \
                        -c "A personal LEDE config with Kadnode and CJDNS pre-installed" \
                        -w "https://github.com/eyedeekay/lede-docker/releases/download/$version_tag/$file_upload-$version_tag.tar.gz" \
                        "$file_upload-$version_tag.tar.gz"
}

release_torrents(){
        for f in $(find "$file_upload/targets" -name *.bin); do
                echo "$f"
                github-release upload \
                        --user eyedeekay \
                        --repo lede-docker \
                        --tag "$version_tag" \
                        --name "$(basename $f).torrent" \
                        --file "$(basename $f).torrent"
        done
        github-release upload \
		--user eyedeekay \
		--repo lede-docker \
		--tag "$version_tag" \
		--name "$file_upload-$version_tag.tar.gz.torrent" \
		--file "$file_upload-$version_tag.tar.gz.torrent"
}


if [ "$1" = "delrelease" ]; then
        delrelease
        exit
fi

prerelease
release_tarball "$file_upload"
release_repository "$file_upload"
release_torrent_repository "$file_upload"
release_images "$file_upload"
release_torrent_image "$file_upload"
release_torrents
