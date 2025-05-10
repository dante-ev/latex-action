FROM ghcr.io/dante-ev/texlive:2025-A

WORKDIR /root

COPY \
  entrypoint.sh \
  /root/

ENTRYPOINT ["/root/entrypoint.sh"]
