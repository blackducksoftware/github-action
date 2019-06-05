FROM openjdk:8-jre

LABEL "homepage"="http://github.com/actions"
LABEL "maintainer"="GitHub Actions <support+actions@github.com>"
LABEL "version"="1.0.0"

LABEL "com.github.actions.name"="Synopsys Detect for GitHub Actions"
LABEL "com.github.actions.description"="Runs signature detect"
LABEL "com.github.actions.icon"="shield"
LABEL "com.github.actions.color"="purple"

COPY LICENSE README.md THIRD_PARTY_NOTICE.md /

RUN apt-get update && \
    apt-get install curl -y && \
    apt-get clean -y

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
