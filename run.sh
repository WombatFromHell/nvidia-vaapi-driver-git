#!/usr/bin/env bash

IMAGE_NAME="nvidia_vaapi_driver_git"

selinux_status() {
  ENFORCING=false
  if command -v getenforce; then
    local enforcing_status=$(getenforce)
    if [ "$enforcing_status" == "Enforcing" ]; then
      ENFORCING=true
    fi
  fi
}

selinux_status
RELABEL=""
if [[ "$ENFORCING" == true ]]; then
  RELABEL=":z"
fi

rm -rf ./output/ &&
  mkdir -p output

docker stop -i "$IMAGE_NAME"
docker rm -f -i "$IMAGE_NAME"

docker build -t "$IMAGE_NAME" .
docker run --rm \
  -v "./output:/output${RELABEL}" \
  --name "$IMAGE_NAME" "$IMAGE_NAME"
