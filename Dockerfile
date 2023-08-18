FROM nodeshift/centos7-s2i-nodejs:latest
LABEL "io.openshift.s2i.build.commit.author"="Jenkins <jenkins@ip-172-31-93-81.ec2.internal>" \
      "io.openshift.s2i.build.commit.date"="Fri Aug 18 09:55:30 2023 +0000" \
      "io.openshift.s2i.build.commit.id"="6d5b25aa98463cf9e424c37e1d5864115b255081" \
      "io.openshift.s2i.build.commit.ref"="staging" \
      "io.openshift.s2i.build.commit.message"="Add Dockerfile-staging" \
      "io.openshift.s2i.build.source-location"="/var/lib/jenkins/workspace/s2i-Demo/temp/Node-app/." \
      "io.openshift.s2i.build.image"="nodeshift/centos7-s2i-nodejs:latest"

USER root
# Copying in source code
COPY upload/src /tmp/src
# Change file ownership to the assemble user. Builder image must support chown command.
RUN chown -R 1001:0 /tmp/src
USER 1001
# Assemble script sourced from builder image based on user input or image metadata.
# If this file does not exist in the image, the build will fail.
RUN /usr/libexec/s2i/assemble
# Run script sourced from builder image based on user input or image metadata.
# If this file does not exist in the image, the build will fail.
CMD /usr/libexec/s2i/run
