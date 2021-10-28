#!/bin/bash
TAG="$(date +%F.%s)"
TOP="${1:-${HOME}/Google_Drive/Workspace}"
REPORT="workspace-scan-${TAG}.md"

echo "# Repo Scan for ${TOP}" | tee "${REPORT}"

for i in $(find "${TOP}" -type d -name .git | sed -e 's/.git//' | sort);
do

    echo "## ${i}"
    cd "${i}" || true

    echo '```'
    origin=$(git remote get-url --all origin)
    repo=$(git remote get-url --all origin | gsed -e 's|:|/|' -e 's|git@|https://|' -e 's|\.com\-[^/]\+|.com|' -e 's|\.git$||')
    echo "Origin: ${origin}"
    echo "Web UI: ${repo}"
    echo '```'

    echo

    echo '```'
    git status
    echo '```'

    echo
done | tee -a "${REPORT}"
