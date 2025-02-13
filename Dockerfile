FROM ghcr.io/dante-ev/texlive:2024-B

WORKDIR /root

COPY \
  entrypoint.sh \
  /root/

ENTRYPOINT ["/root/entrypoint.sh"]
