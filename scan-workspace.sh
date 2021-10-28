#!/bin/bash
TAG="$(date +%F.%s)"
TOP="${1:-~/Google_Drive/Workspace}"
REPORT="workspace-scan-${TAG}.md"

echo "# Repo Scan for ${TOP}" | tee "${REPORT}"

for i in $(find . -type d -name .git | sed -e 's/.git//' | sort);
do

    echo "## ${i}"
    if [ -d "${TOP}/${i}" ];
    then
        cd "${TOP}/${i}" || true

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
    else
        echo "ERROR: Could not change directories to ${i}"
    fi

done | tee -a "${REPORT}"
