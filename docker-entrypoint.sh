#!/bin/bash
set -e
set -o pipefail

# Ensure that the GITHUB_TOKEN secret is included
if [[ -z "$GITHUB_TOKEN" ]]; then
  (>&2 echo "[ERROR] Set the GITHUB_TOKEN env variable");
  exit 1;
fi

# Only upload to non-draft releases
IS_DRAFT=$(jq --raw-output '.release.draft' $GITHUB_EVENT_PATH)
if [ "$IS_DRAFT" = true ]; then
  (>&2 echo "[SKIP] This is a draft, so nothing to do");
  exit 0;
fi

# Prepare the headers
AUTH_HEADER="Authorization: token ${GITHUB_TOKEN}";
CONTENT_LENGTH_HEADER="Content-Length: $(stat -c%s "$INPUT_FILE")";
CONTENT_TYPE_HEADER="Content-Type: $INPUT_TYPE";

# Build the Upload URL from the various pieces
RELEASE_ID=$(jq --raw-output '.release.id' $GITHUB_EVENT_PATH)
if [[ -z "${RELEASE_ID}" ]]; then
  (>&2 echo "[ERROR] There was no release ID in the GitHub event. Are you using the release event type?");
  exit 1;
fi

FILENAME=$(basename $INPUT_FILE);
UPLOAD_URL="https://uploads.github.com/repos/${GITHUB_REPOSITORY}/releases/${RELEASE_ID}/assets?name=${FILENAME}";

if [ "$INPUT_DRY" = true ]; then
  DR="./upload_to_release_dry_run.debug";

  echo "[DRY] Upload url: [$UPLOAD_URL]" > "$DR"
  echo "[DRY] Auth: [$AUTH_HEADER]" >> "$DR";
  echo "[DRY] Content length: [$CONTENT_LENGTH_HEADER]" >> "$DR";
  echo "[DRY] Content type: [$CONTENT_TYPE_HEADER]" >> "$DR";
  echo "[DRY] File: [$INPUT_FILE]" >> "$DR";

  exit 0;
fi

# Upload the file
curl \
  -sSL \
  -XPOST \
  -H "${AUTH_HEADER}" \
  -H "${CONTENT_LENGTH_HEADER}" \
  -H "${CONTENT_TYPE_HEADER}" \
  --upload-file "$INPUT_FILE" \
  "${UPLOAD_URL}";
