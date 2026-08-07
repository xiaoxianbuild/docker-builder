#!/bin/bash
# Default mode is n8n version
MODE=${1:-n8n}
TARGET_VERSION=$2

if [ "$MODE" == "chinese" ]; then
  # Fetch release tags from other-blowsnow/n8n-i18n-chinese
  RELEASES=$(curl -s "https://api.github.com/repos/other-blowsnow/n8n-i18n-chinese/releases?per_page=100" | jq -r '.[].tag_name')

  MATCH=""
  if [ -n "$TARGET_VERSION" ]; then
    # 1. 精确匹配：如 release/2.33.5 或 2.33.5
    MATCH=$(echo "$RELEASES" | grep -E "^(release/)?${TARGET_VERSION}$" | head -n 1)

    # 2. 次选：主/次版本号匹配 (如 2.33.x)
    if [ -z "$MATCH" ]; then
      MAJOR_MINOR=$(echo "$TARGET_VERSION" | cut -d. -f1,2)
      MATCH=$(echo "$RELEASES" | grep -E "^(release/)?${MAJOR_MINOR}\." | head -n 1)
    fi
  fi

  # 3. 兜底：获取中文项目最新的 Release 标签
  if [ -z "$MATCH" ] || [ "$MATCH" == "null" ]; then
    MATCH=$(echo "$RELEASES" | head -n 1)
  fi

  if [ -z "$MATCH" ] || [ "$MATCH" == "null" ]; then
    MATCH="latest"
  fi

  # URL encode slashes for GitHub download links (e.g., release/2.33.5 -> release%2F2.33.5)
  echo "$MATCH" | sed 's/\//%2F/g'
else
  # Fetch non-prerelease stable v2 releases from n8n-io/n8n GitHub Releases API
  LATEST_VERSION=$(curl -s "https://api.github.com/repos/n8n-io/n8n/releases?per_page=50" | jq -r '.[] | select(.prerelease == false) | .tag_name' | sed 's/n8n@//g' | grep -E '^2\.[0-9]+\.[0-9]+$' | sort -V | tail -n 1)

  # Fallback to Docker Hub tags if GitHub API returns empty
  if [ -z "$LATEST_VERSION" ] || [ "$LATEST_VERSION" == "null" ]; then
    TAGS=$(curl -s "https://hub.docker.com/v2/repositories/n8nio/n8n/tags/?page_size=100" | jq -r '.results[].name')
    LATEST_VERSION=$(echo "$TAGS" | grep -E '^2\.[0-9]+\.[0-9]+$' | sort -V | tail -n 1)
  fi

  if [ -z "$LATEST_VERSION" ]; then
    LATEST_VERSION="stable"
  fi

  echo "$LATEST_VERSION"
fi
