# syntax=docker/dockerfile:1.7

FROM lancommander/base:latest

ENV COD_URL="https://github.com/LANCommander/LANCommander.Servers.CallOfDuty/releases/download/1.5b/cod_lnxded-1.5b.zip"

# Server settings
ENV START_EXE="./cod_lnxded"
ENV START_ARGS="+set dedicated 2 +set sv_allowDownload 1 +set sv_dlURL \"\" +set com_hunkmegs 64"
ENV HTTP_FILESERVER_ENABLED="true"
ENV HTTP_FILESERVER_WEB_ROOT="/config/Merged"
ENV HTTP_FILESERVER_FILE_PATTERN="^/.*\.(pk3|arena|bot|jpg|tga|wav|ogg)$"

# ----------------------------
# Dependencies
# ----------------------------
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    bzip2 \
    tar \
    unzip \
    xz-utils \
    p7zip-full \
    gosu \
  && rm -rf /var/lib/apt/lists/*

EXPOSE 28960/udp

# COPY Modules/ "${BASE_MODULES}/"
COPY Hooks/ "${BASE_HOOKS}/"

WORKDIR /config
ENTRYPOINT ["/usr/local/bin/entrypoint.ps1"]