# GitHub Action for Synopsys Detect

## Overview

The Synopsys Detect GitHub Action makes it easy to scan GitHub repositories with Synopsys Application Security tools, which include the scanning functionality of Coverity on Polaris and Black Duck. Synopsys Detect makes it easy to set up and scan codebases that use a variety of languages and package managers. The Synopsys Detect GitHub Action allows your organization to easily add vulnerability testing on a variety of GitHub Platform events, such as push, pull, issue, and release.

## Example YAML config for Synopsys Detect version 7

```yaml

name: Java CI

on: [push]

jobs:
  build:

    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v1
      - name: Set up JDK 1.8
        uses: actions/setup-java@v1
        with:
          java-version: 1.8
      # -- Build your project here -- eg. mvn clean package
      - name: Synopsys Detect
        uses: blackducksoftware/github-action@v2.2
        with:
          version: 7
          blackduck.url: ${{ secrets.BLACKDUCK_URL }}
          blackduck.api.token: ${{ secrets.BLACKDUCK_API_TOKEN }}
          args: --detect.risk.report.pdf=true

```

## Example YAML config for running Rapid Scan

```yaml

name: Java CI

on: [push]

jobs:
  build:

    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v1
      - name: Set up JDK 1.8
        uses: actions/setup-java@v1
        with:
          java-version: 1.8
      # -- Build your project here -- eg. mvn clean package
      - name: Synopsys Detect
        uses: blackducksoftware/github-action@v2.2
        with:
          version: 7
          blackduck.url: ${{ secrets.BLACKDUCK_URL }}
          blackduck.api.token: ${{ secrets.BLACKDUCK_API_TOKEN }}
          args: >
            --detect.blackduck.scan.mode=RAPID
            --detect.policy.check.fail.on.severities="BLOCKER"

```

## Example YAML config for older Synopsys Detect versions (prior to 7)

```yaml

name: Java CI

on: [push]

jobs:
  build:

    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v1
      - name: Set up JDK 1.8
        uses: actions/setup-java@v1
        with:
          java-version: 1.8
      # -- Build your project here -- eg. mvn clean package
      - name: Synopsys Detect
        uses: blackducksoftware/github-action@v2.2
        with:
          blackduck.url: ${{ secrets.BLACKDUCK_URL }}
          blackduck.api.token: ${{ secrets.BLACKDUCK_API_TOKEN }}
          args: '--detect.risk.report.pdf=true'

```

## Running this GitHub Action locally  (w/o GitHub Actions)

```bash
env INPUT_ARGS="--blackduck.url='<>' --blackduck.api.token='<>'" INPUT_VERSION="7" node index.js
```
