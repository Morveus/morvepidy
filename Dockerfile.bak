# Use Debian as the base image
FROM debian:bullseye-slim

# Set environment variables to prevent prompts
ENV DEBIAN_FRONTEND=noninteractive

# Update and install MPD, Rygel and their dependencies
RUN apt-get update && apt-get install -y \
    mpd \
    rygel \
    && rm -rf /var/lib/apt/lists/*

# Copy over configuration files (assuming they are in the current directory)
COPY mpd.conf /etc/mpd.conf
COPY rygel.conf /etc/rygel.conf

# Expose MPD and Rygel ports
EXPOSE 6600 1900/udp 5000 5002

# Start MPD and Rygel
CMD ["sh", "-c", "mpd --no-daemon && rygel"]
