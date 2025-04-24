#!/usr/bin/env bash

# Fetch the latest stable Kubernetes version
latest_version=$(curl -L -s https://dl.k8s.io/release/stable.txt)

# Process the version to remove 'v' prefix and patch version
latest_version=$(echo "$latest_version" | sed 's/^v//' | cut -d'.' -f1,2)

echo "latest_version:"$latest_version

# Extract the current version from generate.sh
current_version=$(head -n 1 /workspace/kcl-artifacthub/scripts/k8s/generate.sh | cut -d'=' -f2)

# Compare versions and update if necessary
if [[ "$latest_version" != "$current_version" ]]; then
    echo "Updating version from $current_version to $latest_version in generate.sh"
    sed -i "1s/^version=.*/version=$latest_version/" /workspace/kcl-artifacthub/scripts/k8s/generate.sh
else
    echo "Version $current_version is already up-to-date."
    exit 0
fi

./generate.sh
mkdir -p ../../k8s/$latest_version
mv models/k8s/* ../../k8s/$latest_version
cd ../../k8s/$latest_version
kcl mod init  k8s --version $latest_version
mv k8s/* .
rm -f main.k
git status
