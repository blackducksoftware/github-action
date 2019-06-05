# CHANGE THIS IMAGE TO THE BASE IMG FROM YOUR BUILD TOOL

# FOR A MAVEN PROJECT THE BELOW BASE IMG WORKS FINE

FROM maven:3.6.1-jdk-8

RUN  apt-get update \
  && apt-get install -y wget \
  && apt-get install -y unzip \
  && rm -rf /var/lib/apt/lists/*

# DO NOT EDIT BELOW THIS LINE

ENV SWIP_ACCESS_TOKEN=$SWIP_ACCESS_TOKEN
ENV SWIP_SERVER_URL=$SWIP_SERVER_URL
ENV SWIP_HOME /.swip
RUN mkdir /.swip && wget https://polaris.synopsys.com/api/tools/swip_cli-linux64.zip -O /tmp/swip_cli-linux64.zip \
&& unzip /tmp/swip_cli-linux64.zip -d /tmp/swip_cli-linux64 \
&& rm /tmp/swip_cli-linux64.zip && cp /tmp/swip_cli-linux64/**/bin/* /usr/bin
ENTRYPOINT [ "swip_cli", "analyze", "-w" ]
