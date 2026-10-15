FROM ghcr.io/dante-ev/texlive:2026-B

WORKDIR /root

COPY \
  entrypoint.sh \
  /root/

ENTRYPOINT ["/root/entrypoint.sh"]
