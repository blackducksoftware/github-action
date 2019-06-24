FROM openjdk:8-jre

LABEL "homepage"="https://github.com/blackducksoftware/github-action"
LABEL "maintainer"="Gautam Baghel <gautamb@synopsys.com>"
LABEL "version"="1.0.1"

LABEL "com.github.actions.name"="Synopsys Detect Action"
LABEL "com.github.actions.description"="Run Synopsys Detect to find code quality and security issues with Coverity and Black Duck"
LABEL "com.github.actions.icon"="shield"
LABEL "com.github.actions.color"="purple"

COPY LICENSE README.md THIRD_PARTY_NOTICE.md /

RUN apt-get update && \
    apt-get install curl -y && \
    apt-get clean -y

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
