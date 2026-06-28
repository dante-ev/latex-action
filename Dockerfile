FROM ghcr.io/dante-ev/texlive:2026-A

WORKDIR /root

COPY \
  entrypoint.sh \
  /root/

ENTRYPOINT ["/root/entrypoint.sh"]
