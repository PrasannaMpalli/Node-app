FROM nodeshift/centos7-s2i-nodejs:latest
LABEL "io.openshift.s2i.build.source-location"="/var/lib/jenkins/workspace/s2i-Demo/temp/Node-app/." \
      "io.openshift.s2i.build.image"="nodeshift/centos7-s2i-nodejs:latest" \
      "io.openshift.s2i.build.commit.author"="Jenkins <jenkins@ip-172-31-93-81.ec2.internal>" \
      "io.openshift.s2i.build.commit.date"="Thu Aug 17 10:18:45 2023 +0000" \
      "io.openshift.s2i.build.commit.id"="5ab77f701f74ba203dd79b6b03f2e8fa649a2457" \
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
