[![CHUV](https://img.shields.io/badge/CHUV-LREN-AF4C64.svg)](https://www.unil.ch/lren/en/home.html) [![License](https://img.shields.io/badge/license-Apache--2.0-blue.svg)](https://github.com/LREN-CHUV/docker-compose-for-ci/blob/master/LICENSE) [![DockerHub](https://img.shields.io/badge/docker-hbpmip%2Fdocker--compose--for--ci-008bb8.svg)](https://hub.docker.com/r/hbpmip/docker-compose-for-ci/) [![ImageVersion](https://images.microbadger.com/badges/version/hbpmip/docker-compose-for-ci.svg)](https://hub.docker.com/r/hbpmip/docker-compose-for-ci/tags "hbpmip/docker-compose-for-ci image tags") [![ImageLayers](https://images.microbadger.com/badges/image/hbpmip/docker-compose-for-ci.svg)](https://microbadger.com/#/images/hbpmip/docker-compose-for-ci "hbpmip/docker-compose-for-ci on microbadger") [![Codacy Badge](https://api.codacy.com/project/badge/Grade/TODO)](https://www.codacy.com/app/hbp-mip/docker-compose-for-ci?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=LREN-CHUV/docker-compose-for-ci&amp;utm_campaign=Badge_Grade) [![CircleCI](https://circleci.com/gh/LREN-CHUV/docker-compose-for-ci.svg?style=svg)](https://circleci.com/gh/LREN-CHUV/docker-compose-for-ci)

# Docker image for Ubuntu used for continuous builds

Base Ubuntu image to use when building and testing projects in continuous integration (e.g. [CircleCI](https://circleci.com)).

## Introduction

This project provides a build environment for our projects on CircleCI.

It provides:

* Ubuntu
* git
* Ansible
* pre-commit, shellcheck, ansible-lint
* A 'tester' user

## Usage

Example:

.circleci/config.yml:

```
version: 2
jobs:
  build:
    working_directory: ~/src
    docker:
      - image: hbpmip/ubuntu-for-ci:16.04-1
    environment:
       - CIRCLECI: true
    steps:
      - checkout
      - run:
          name: "Install requirements"
          command: |
            pre-commit install
      - run:
          name: "Validate code quality"
          command: |
            pre-commit run --all-files
      - run:
          name: "Build the project"
          command: |
            ./build.sh
      - run:
          name: "Test the project"
          command: |
            ./tests/test.sh

```

## Build

Run: `./build.sh`

## Publish on Docker Hub

Run: `./publish.sh`

## License

### ubuntu-ci

(This project)

This is the MIT license: http://www.opensource.org/licenses/mit-license.php

Copyright (C) 2017 [LREN CHUV](https://www.unil.ch/lren/en/home.html)

Permission is hereby granted, free of charge, to any person obtaining a copy of this
software and associated documentation files (the "Software"), to deal in the Software
without restriction, including without limitation the rights to use, copy, modify, merge,
publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons
to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or
substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.
