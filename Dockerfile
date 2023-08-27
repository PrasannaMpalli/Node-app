FROM nodeshift/centos7-s2i-nodejs:latest
LABEL "io.openshift.s2i.build.commit.date"="Sun Aug 27 15:24:23 2023 +0000" \
      "io.openshift.s2i.build.commit.id"="0d364a85c611a9244f1cc93a66e40f2ec77f7422" \
      "io.openshift.s2i.build.commit.ref"="staging" \
      "io.openshift.s2i.build.commit.message"="Add Dockerfile-staging" \
      "io.openshift.s2i.build.source-location"="/var/lib/jenkins/workspace/S2i-demo/temp/Node-app/." \
      "io.openshift.s2i.build.image"="nodeshift/centos7-s2i-nodejs:latest" \
      "io.openshift.s2i.build.commit.author"="Jenkins <jenkins@ip-172-31-11-152.ap-south-1.compute.internal>"

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
