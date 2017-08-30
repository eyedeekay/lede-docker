#! /usr/bin/env sh
github-release release \
		--user eyedeekay \
		--repo lede-docker \
		--tag $(date +%Y%m%d%H%M) \
		--name "meshledeconfig" \
		--description "A personal LEDE config with Kadnode and CJDNS pre-installed" \
		--pre-release

for file_upload in $(find . -name *.img); do
        github-release upload \
		--user eyedeekay \
		--repo lede-docker \
		--tag v0.1.0 \
		--name "meshledeconfig" \
		--file "$file_upload"
                mktorrent -a udp://tracker.openbittorrent.com:80 \
                        -a udp://tracker.publicbt.com:80 \
                        -a udp://tracker.opentrackr.org:1337 \
                        -c "A personal LEDE config with Kadnode and CJDNS pre-installed" \
                        -w
done

for file_upload in $(find . -name *.bin); do
        github-release upload \
		--user eyedeekay \
		--repo lede-docker \
		--tag v0.1.0 \
		--name "meshledeconfig" \
		--file "$file_upload"
                mktorrent -a udp://tracker.openbittorrent.com:80 \
                        -a udp://tracker.publicbt.com:80 \
                        -a udp://tracker.opentrackr.org:1337 \
                        -c "A personal LEDE config with Kadnode and CJDNS pre-installed" \
                        -w
done
