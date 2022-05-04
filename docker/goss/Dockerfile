FROM centos:7

ENV GOSS_FILE /goss/browser/goss.yaml
ENV GOSS_BUILDTIME_FILE /goss/browser/buildtime.yaml

#can not enable as goss interfer with std output which then make browser fail
ENV GOSS_SERVE_ENABLED false
ENV GOSS_SERVE_PORT 5000

COPY ./goss /goss

HEALTHCHECK --interval=30s --timeout=30s --start-period=30s --retries=10 CMD goss -g /goss/goss.yaml validate

EXPOSE $P8080

CMD ["bash","/docker-entrypoint.bash"]

