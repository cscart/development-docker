FROM nginx:stable-alpine

RUN apk add --update --no-cache \
    ca-certificates \
    bc \
    wget \
    socat \
    openssl \
    supervisor \
    coreutils \
 && rm -rf /tmp/* /var/cache/apk/* \
 && wget -O -  https://get.acme.sh | sh && rm -rf /install_acme.sh/ \
 && ln -s  /root/.acme.sh/acme.sh  /usr/local/bin/acme.sh && crontab -l | grep acme.sh | sed 's#> /dev/null##' | crontab - \
 && for verb in help \ 
  version \
  install \
  uninstall \
  upgrade \
  issue \
  signcsr \
  deploy \
  install-cert \
  renew \
  renew-all \
  revoke \
  remove \
  list \
  showcsr \
  install-cronjob \
  uninstall-cronjob \
  cron \
  toPkcs \
  toPkcs8 \
  update-account \
  register-account \
  create-account-key \
  create-domain-key \
  createCSR \
  deactivate \
  deactivate-account \
  ; do \
    printf -- "%b" "#!/usr/bin/env sh\n/root/.acme.sh/acme.sh --${verb} --config-home /acme.sh \"\$@\"" >/usr/local/bin/--${verb} && chmod +x /usr/local/bin/--${verb} \
  ; done \
 && mkdir /etc/nginx/xtra \
 && ln -sf /dev/stdout /var/log/nginx/access.log \
 && ln -sf /dev/stderr /var/log/nginx/error.log

COPY --chown=root:root ssl /etc/nginx/ssl
COPY --chown=root:root html /etc/nginx/html  
COPY --chown=root:root templates /etc/nginx/templates
COPY --chown=root:root nginx.conf /etc/nginx/
COPY --chown=root:root supervisord.conf /etc/supervisord.conf
COPY --chown=root:root init.sh /
COPY --chown=root:root ssl_init.sh /

RUN chmod +x /init.sh /ssl_init.sh \
    && crontab -l > /cron_job \
	&& echo -e '00 06 * * * /init.sh' >> /cron_job \
    && crontab /cron_job