ARG N8N_VERSION=stable
ARG CHINESE_VERSION=latest

# Stage 1: Download and extract chinese language pack
FROM alpine:latest AS downloader
ARG CHINESE_VERSION
RUN apk add --no-cache curl tar
RUN mkdir -p /tmp/chinese
RUN curl -L "https://github.com/other-blowsnow/n8n-i18n-chinese/releases/download/${CHINESE_VERSION}/editor-ui.tar.gz" -o /tmp/editor-ui.tar.gz \
    && tar -xzf /tmp/editor-ui.tar.gz -C /tmp/chinese --strip-components=1

# Stage 2: Final n8n image
FROM n8nio/n8n:${N8N_VERSION}

USER root

# Copy extracted chinese assets from downloader stage to the correct location
RUN rm -rf /usr/local/lib/node_modules/n8n/node_modules/n8n-editor-ui/dist
COPY --from=downloader /tmp/chinese /usr/local/lib/node_modules/n8n/node_modules/n8n-editor-ui/dist

ENV N8N_DEFAULT_LOCALE=zh-CN
ENV GENERIC_TIMEZONE=Asia/Shanghai
ENV TZ=Asia/Shanghai

# Isolate n8n (Disable telemetry and external notifications)
ENV N8N_DIAGNOSTICS_ENABLED=false
ENV N8N_VERSION_NOTIFICATIONS_ENABLED=false
ENV N8N_TEMPLATES_ENABLED=false
ENV N8N_PERSONALIZATION_ENABLED=false
ENV EXTERNAL_FRONTEND_HOOKS_URLS=""
ENV N8N_DIAGNOSTICS_CONFIG_FRONTEND=""
ENV N8N_DIAGNOSTICS_CONFIG_BACKEND=""

USER node

ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]
