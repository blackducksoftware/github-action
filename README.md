# GitHub Action for Synopsys Detect

## Overview

The Synopsys Detect GitHub Action makes it easy to scan GitHub repositories with Synopsys Application Security tools, which include the scanning functionality of Coverity on Polaris and Black Duck. Synopsys Detect makes it easy to set up and scan codebases that use a variety of languages and package managers. The Synopsys Detect GitHub Action allows your organization to easily add vulnerability testing on a variety of GitHub Platform events, such as push, pull, issue, and release.

## Usage
See the <a href="https://synopsys.atlassian.net/wiki/spaces/PARTNERS/pages/151093290/Synopsys+Detect+GitHub+Action" target="_blank">official documentation</a> on how to use this action.

## New YAML configs (Official docs will be updated soon)

``` 
name: Java CI

on: [push]

jobs:
  build:

    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout
        uses: actions/checkout@2.0.0
      - name: Polaris
        uses: ./
        with:
          args: '--polaris.url="${{ secrets.POLARIS_URL}}" --polaris.access.token="${{ secrets.POLARIS_TOKEN}}" --detect.tools="POLARIS"'
      - name: Synopsys Detect
        uses: ./
        with:
          args: '--blackduck.url="${{ secrets.BLACKDUCK_URL}}" --blackduck.api.token="${{ secrets.BLACKDUCK_API_TOKEN}}" --detect.risk.report.pdf=true'

```
