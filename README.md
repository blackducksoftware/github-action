# GitHub Action for Synopsys Detect

## Overview

The Synopsys Detect GitHub Action makes it easy to scan GitHub repositories with Synopsys Application Security tools, which include the scanning functionality of Coverity on Polaris and Black Duck. Synopsys Detect makes it easy to set up and scan codebases that use a variety of languages and package managers. The Synopsys Detect GitHub Action allows your organization to easily add vulnerability testing on a variety of GitHub Platform events, such as push, pull, issue, and release.

## Example YAML config (See <a href="https://synopsys.atlassian.net/wiki/spaces/PARTNERS/pages/151093290/Synopsys+Detect+GitHub+Action" target="_blank">official documentation</a> for more information)

``` 
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
      - name: Polaris
        uses: blackducksoftware/github-action@2.0.0
        with:
          args: '--polaris.url="${{ secrets.POLARIS_URL}}" --polaris.access.token="${{ secrets.POLARIS_TOKEN}}" --detect.tools="POLARIS"'
      - name: Synopsys Detect
        uses: blackducksoftware/github-action@2.0.0
        with:
          args: '--blackduck.url="${{ secrets.BLACKDUCK_URL}}" --blackduck.api.token="${{ secrets.BLACKDUCK_API_TOKEN}}" --detect.risk.report.pdf=true'

```
