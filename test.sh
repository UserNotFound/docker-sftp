#!/bin/bash
set -o errexit
set -o nounset

IMG="$REGISTRY/$REPOSITORY:$TAG"

echo "Unit Tests..."
docker run -it --rm --entrypoint "bash" "$IMG" \
 -c "apt-get -y install sshpass && chmod 600 /tmp/test/testkey && bats /tmp/test"


TESTS=(
)

for t in "${TESTS[@]}"; do
  echo "--- START ${t} ---"
  "./${t}.sh" "$IMG"
  echo "--- OK    ${t} ---"
  echo
done

echo "#############"
echo "# Tests OK! #"
echo "#############"