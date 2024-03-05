#!/bin/sh

while [ ! -d "/entrypoint/done.wp" ]; do
    sleep 1
done

netstat -tuln | grep LISTEN | grep 0.0.0.0:9000;