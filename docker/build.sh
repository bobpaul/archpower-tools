#!/usr/bin/bash
set -e

docker build --platform linux/ppc64le --no-cache --rm -t kth5/archpower:$(date "+%Y%m%d")-ppc64le -t kth5/archpower:latest-ppc64le .
for arch in riscv64 ppc ppc64; do
  docker build --platform linux/${arch} --rm -t kth5/archpower:$(date "+%Y%m%d")-${arch} -t kth5/archpower:latest-${arch} .
done

