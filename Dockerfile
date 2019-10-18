FROM alpine:latest

LABEL repository="https://github.com/actions-github/upload-to-release" \
      homepage="https://github.com/actions-github/upload-to-release" \
      maintainer="https://github.com/actions-github" \
      com.github.actions.name="Upload asset to release" \
      com.github.actions.description="Uploads a file to a GitHub release" \
      com.github.actions.icon="package" \
      com.github.actions.color="blue"

RUN apk update && apk add --no-cache bash ca-certificates curl jq

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
