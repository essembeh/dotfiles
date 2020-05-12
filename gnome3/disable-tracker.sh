#!/bin/sh

systemctl --user mask \
	tracker-store.service \
	tracker-miner-fs.service \
	tracker-miner-rss.service \
	tracker-extract.service \
	tracker-miner-apps.service \
	tracker-writeback.service

tracker reset --hard
