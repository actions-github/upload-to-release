<p align="center">
  <img src="https://avatars0.githubusercontent.com/u/44036562?s=200&v=4" alt="Logo" width="128" />
</p>

![Release version][badge_release_version]
[![Docker Build][badge_docker_build]][link_docker_hub]
[![Build Status][badge_build]][link_build]
[![License][badge_license]][link_license]

This action uploads any file to a new release:

<p align="center">
    <img src="https://hsto.org/webt/w6/2-/kw/w62-kwnnzrwvcgv737686qotjpc.png" width="900">
</p>

> Action idea looked in [JasonEtco/upload-to-release](https://github.com/JasonEtco/upload-to-release)

## Usage

Example:

```yaml
steps:
- name: Build application
  run: |
    printf %s 'package main;import "fmt";func main(){fmt.Println("hi")}' > main.go
    go build -o ./hi main.go

- name: Upload asset to release
  uses: gacts/upload-to-release@master
  env:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
  with:
    file: './hi'
    type: 'application/octet-stream'

# Or use ready docker image:

- name: Upload asset to release
  uses: docker://gacts/upload-to-release:latest
  env:
    GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
  with:
    file: './hi'
    type: 'application/octet-stream'
```

All **types** list can be [found here](https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types/Complete_list_of_MIME_types).

## Support

[![Issues][badge_issues]][link_issues]
[![Issues][badge_pulls]][link_pulls]

If you will find any package errors, please, [make an issue][link_create_issue] in current repository.

## License

This is open-sourced software licensed under the [WTFPL License][link_license].

[badge_build]:https://github.com/gacts/upload-to-release/workflows/Test%20action/badge.svg
[badge_docker_build]:https://img.shields.io/docker/cloud/build/gacts/upload-to-release.svg?maxAge=30
[badge_release_version]:https://img.shields.io/github/release/gacts/upload-to-release.svg?maxAge=30
[badge_license]:https://img.shields.io/github/license/gacts/upload-to-release.svg?longCache=true
[badge_issues]:https://img.shields.io/github/issues/gacts/upload-to-release.svg?maxAge=45
[badge_pulls]:https://img.shields.io/github/issues-pr/gacts/upload-to-release.svg?maxAge=45

[link_build]:https://github.com/gacts/upload-to-release/actions
[link_license]:https://github.com/gacts/upload-to-release/blob/master/LICENSE
[link_issues]:https://github.com/gacts/upload-to-release/issues
[link_create_issue]:https://github.com/gacts/upload-to-release/issues/new
[link_pulls]:https://github.com/gacts/upload-to-release/pulls
[link_docker_hub]:https://hub.docker.com/r/gacts/upload-to-release
