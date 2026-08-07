#!/bin/bash
# Default mode is n8n version
MODE=${1:-n8n}

if [ "$MODE" == "chinese" ]; then
  # Fetch latest release tag from other-blowsnow/n8n-i18n-chinese
  LATEST_CHINESE=$(curl -s "https://api.github.com/repos/other-blowsnow/n8n-i18n-chinese/releases/latest" | jq -r '.tag_name')
  if [ -z "$LATEST_CHINESE" ] || [ "$LATEST_CHINESE" == "null" ]; then
    LATEST_CHINESE="latest"
  fi
  # URL encode slashes for GitHub download links (e.g., release/2.33.5 -> release%2F2.33.5)
  echo "$LATEST_CHINESE" | sed 's/\//%2F/g'
else
  # Fetch all tags and find the latest stable-looking version (1.x, 2.x, or 3.x)
  # We exclude nightly, beta, and architecture-specific tags
  TAGS=$(curl -s "https://hub.docker.com/v2/repositories/n8nio/n8n/tags/?page_size=100" | jq -r '.results[].name')

  LATEST_VERSION=$(echo "$TAGS" | grep -E '^[0-9]+\.[0-9]+\.[0-9]+$' | sort -V | tail -n 1)

  if [ -z "$LATEST_VERSION" ]; then
    LATEST_VERSION="stable"
  fi

  echo "$LATEST_VERSION"
fi
