FROM nodeshift/centos7-s2i-nodejs:latest
LABEL "io.openshift.s2i.build.source-location"="/var/lib/jenkins/workspace/S2i-demo/temp/Node-app/." \
      "io.openshift.s2i.build.image"="nodeshift/centos7-s2i-nodejs:latest" \
      "io.openshift.s2i.build.commit.author"="Jenkins <jenkins@ip-172-31-11-152.ap-south-1.compute.internal>" \
      "io.openshift.s2i.build.commit.date"="Sun Aug 27 15:26:08 2023 +0000" \
      "io.openshift.s2i.build.commit.id"="9705ac006855784324daf3e9df00b4480eef6401" \
      "io.openshift.s2i.build.commit.ref"="staging" \
      "io.openshift.s2i.build.commit.message"="Add Dockerfile-staging"

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
