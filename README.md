# GitHub Action for Synopsys Detect

This Action is for scanning vulnerabilities on your source code, it enables scanning a repository with [`Synopsys Detect`](https://synopsys.atlassian.net/wiki/spaces/INTDOCS/pages/62423113/Synopsys+Detect), Synopsys Detect (formerly Hub Detect) consolidates the functionality of Black Duck™ and Coverity™ on Polaris™ tools into a single tool. Synopsys Detect also makes it easier to set up and scan code bases using a variety of languages and package managers.  

## Usage

Including Synopsys detect in your workflow is fairly simple. Just select Synopsys-detect from [Github Marketplace](https://github.com/marketplace/actions/) and click on use the latest version to include it in your workspace. Detailed description on using Actions is provided by Github [Learn more](https://help.github.com/en/articles/creating-a-workflow-with-github-actions) about creating a workflow and adding new actions to the workflow.

## Basic Usage

An example workflow to build, detect, and Tag a maven project to scan the application is as follows:

```
workflow "Build, Test, and Publish" {
  on = "push"
  resolves = ["Publish"]
}

# User defined maven compiler action (Not currently in actions store)
action "Build" {
  uses = "gautambaghel/ducky-crm/maven-cli@master"
  args = "clean package"
}

# The Detect block, override the arguments to configure options as required
action "Synopsys detect" {
  needs = "Build"
  uses = "actions/synopsys-detect@master"
  secrets = ["BLACKDUCK_API_TOKEN", "BLACKDUCK_URL"]
  args = "--detect.tools=SIGNATURE_SCAN --detect.project.name=$GITHUB_REPOSITORY"
}

# Filter for a new tag
action "Tag" {
  needs = "Test"
  uses = "actions/bin/filter@master"
  args = "tag"
}

```

### Secrets

* `BLACKDUCK_API_TOKEN` - **REQUIRED**. The token to use for authentication with the blackduck server. Required for scan initiations ([more info](https://synopsys.atlassian.net/wiki/spaces/INTDOCS/pages/62423113/Synopsys+Detect#SynopsysDetect-Providingcredentials))
* `BLACKDUCK_URL` - **REQUIRED**. The URL to use for scan to reside with detect. Required for scan initiations ([more info](https://synopsys.atlassian.net/wiki/spaces/INTDOCS/pages/62423113/Synopsys+Detect#SynopsysDetect-Providingcredentials))

## Scan Containers
You can scan entire containers running your application using this Action. Given below is an example workflow of how to do that. Rename **CONTAINER_NAME** as required.

```
workflow "Build and Container Scan" {
  on = "push"
  resolves = "Synopsys Detect"
}

# User defined maven compiler action (Not currently in actions store)
action "Build Maven" {
  uses = "gautambaghel/ducky-crm/maven-cli@master"
  args = ["clean package"]
}

action "Build Container" {
  needs = ["Build Maven"]
  uses = "actions/docker/cli@master"
  args = "build -t $GITHUB_REPOSITORY ."
}

action "Save to Tar" {
  needs = ["Build Container"]
  uses = "actions/docker/cli@master"
  args = "save $GITHUB_REPOSITORY > CONTAINER_NAME.tar"
}

action "Synopsys Detect" {
  needs = ["Save to Tar"]
  uses = "gautambaghel/synopsys-detect@master"
  secrets = ["BLACKDUCK_URL","BLACKDUCK_API_TOKEN","SWIP_ACCESS_TOKEN", "SWIP_SERVER_URL"]
  args = "--detect.tools=SIGNATURE_SCAN --detect.project.name=ACTION_CONTAINER_SCAN --detect.source.path=CONTAINER_NAME.tar"
}
```

# Using this Action to run Polaris

Although Polaris™ generates it's own build commands depending on the project manager used we strongly recommend having your own *swip.yml* file in the repository.

## Buildless Capture

Including a file like this in the repository with the name *swip.yml* should run a buildless capture in Polaris™. Make sure to include all the languages used in repo.

```
version: "1"
project:
  name: Project-Name
  branch: master
  revision:
    name: Project-Name-Buildless
    date: 2019-04-20T13:25:30Z
    modified: "false"
capture:
  tools:
   coverity:
    2018.12:
     buildless:
      project:
       languages:
         - "java"
install:
  coverity:
    version: latest
serverUrl: https://polaris.synopsys.com
```

Then just including the Polaris™ URL and Access Token in detect should suffice.

```

action "Polaris" {
  uses = "gautambaghel/synopsys-detect@master"
  secrets = ["BLACKDUCK_URL","BLACKDUCK_API_TOKEN","SWIP_ACCESS_TOKEN", "SWIP_SERVER_URL"]
  args = "--detect.tools=POLARIS --detect.project.name=$GITHUB_REPOSITORY --polaris.url=$SWIP_SERVER_URL --polaris.access.token=$SWIP_ACCESS_TOKEN"
}

```

## Build Capture

For build capture to work Polaris requires build commands and the docker container should have appropriate build dependencies. This means that the Dockerfile must reside in local repository.

In the polaris folder here is defined a Dockerfile, for a build capture you need to use the Base Image used during the build phase. For example for a Maven project base image would be something like "maven:3.6.1-jdk-8". (Refrain from using alpine based images as some commands may not work)

The Dockerfile template is shown in the [polaris folder](/polaris) of this repo.
Follow these steps to run Polaris

Step 1: Create a folder in your repo name "polaris"

Step 2: Insert the edited Dockerfile from the template shown [here](/polaris) in the newly created polaris folder.

Step 3: Use custom action block in the workflow like this

```

action "Polaris" {
  uses = "./polaris"
  secrets = ["SWIP_ACCESS_TOKEN", "SWIP_SERVER_URL"]
}

```
Step 4: Run the workflow and check the logs.

## License

The Dockerfile and associated scripts and documentation in this project are released under the [APACHE 2.0](LICENSE).

Container images built with this project include third party materials. See [THIRD_PARTY_NOTICE.md](THIRD_PARTY_NOTICE.md) for details.
