#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/TheThingsNetwork/lorawan-stack"
TOOL_NAME="ttn-lw-cli"
TOOL_TEST="ttn-lw-cli version"

fail() {
  echo -e "asdf-$TOOL_NAME: $*"
  exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if ttn-lw-cli is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
  curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
  git ls-remote --tags --refs "$GH_REPO" |
    grep -o 'refs/tags/.*' | cut -d/ -f3- |
    sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
  # Change this function if ttn-lw-cli has other means of determining installable versions.
  list_github_tags
}

download_release() {
  local version filename url platform arch
  version="$1"
  filename="$2"
  platform="$(get_platform)"
  arch="$(get_arch)"

  url="$GH_REPO/releases/download/v${version}/lorawan-stack-cli_${version}_${platform}_${arch}.tar.gz"

  echo "* Downloading $TOOL_NAME release $version..."
  curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="$3"

  if [ "$install_type" != "version" ]; then
    fail "asdf-$TOOL_NAME supports release installs only"
  fi

  (
    mkdir -p "$install_path/bin"
    cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path/bin/"

    local tool_cmd
    tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
    test -x "$install_path/bin/$tool_cmd" || fail "Expected $install_path/bin/$tool_cmd to be executable."

    echo "$TOOL_NAME $version installation was successful!"
  ) || (
    rm -rf "$install_path"
    fail "An error occurred while installing $TOOL_NAME $version."
  )
}

get_platform() {
  local silent=${1:-}
  local platform=""

  platform="$(uname | tr '[:upper:]' '[:lower:]')"

  case "$platform" in
  linux*)
    local platform=linux
    ;;
  darwin*)
    local platform=darwin
    ;;
  *)
    err "Platform '${platform}' not supported!"
    exit 1
    ;;
  esac

  echo -n "$platform"
}

get_arch() {
  local arch=""

  case "$(uname -m)" in
  x86_64 | amd64) arch="amd64" ;;
  aarch64) arch="arm64" ;;
  armv6l) arch="armv6" ;;
  armv7l) arch="armv7" ;;
  i386) arch="386" ;;
  *)
    err "Arch '$(uname -m)' not supported!"
    exit 1
    ;;
  esac

  echo -n $arch
}