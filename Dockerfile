FROM nanobox/runit

# Create directories
RUN mkdir -p \
  /var/log/gonano \
  /var/nanobox \
  /opt/nanobox/hooks

# Install ipvsadm, iptables, nginx, and rsync
RUN apt-get update -qq && \
    apt-get install -y ipvsadm iptables nginx rsync iputils-arping && \
    apt-get clean all && \
    rm -rf /var/lib/apt/lists/*

# Download portal
RUN curl \
      -f \
      -k \
      -o /usr/local/bin/portal \
      https://d3ep67zochz54j.cloudfront.net/portal/linux/amd64/portal && \
    chmod 755 /usr/local/bin/portal

# Download md5 (used to perform updates in hooks)
RUN curl \
      -f \
      -k \
      -o /var/nanobox/portal.md5 \
      https://d3ep67zochz54j.cloudfront.net/portal/linux/amd64/portal.md5

# Install hooks
RUN curl \
      -f \
      -k \
      https://d1ormdui8qdvue.cloudfront.net/hooks/portal-stable.tgz \
        | tar -xz -C /opt/nanobox/hooks

# Download hooks md5 (used to perform updates)
RUN curl \
      -f \
      -k \
      -o /var/nanobox/hooks.md5 \
      https://d1ormdui8qdvue.cloudfront.net/hooks/portal-stable.md5

# Run runit automatically
CMD [ "/opt/gonano/bin/nanoinit" ]
