FROM bitnami/minideb:latest

RUN apt-get update && apt-get install -y \
	python3-pip \
	wget \
	sudo \
        rygel \
        nano \
        cron \
	&& rm -rf /var/lib/apt/lists/*

RUN wget -q -O - https://apt.mopidy.com/mopidy.gpg | apt-key add - && \
	wget -q -O /etc/apt/sources.list.d/mopidy.list https://apt.mopidy.com/stretch.list && \
	apt-get update && \
	apt-get install -y \
	libspotify12 \
	libspotify-dev \
	python3-gi \
	python3-gst-1.0 \
	gir1.2-gstreamer-1.0 \
	gir1.2-gst-plugins-base-1.0 \
	gstreamer1.0-plugins-good \
	gstreamer1.0-plugins-ugly \
	gstreamer1.0-tools 

# I'm not interested in using the official APT repo
RUN pip3 install \
	pyspotify \
	mopidy \
	mopidy-spotify \
	mopidy-iris \
	mopidy-local \
	setuptools \
	pykka \
	requests \
	pyspotify --break-system-packages 

RUN crontab -l | { cat; echo "0 0 * * * /usr/local/bin/mopidy local scan"; } | crontab -

COPY mopidy.conf /root/.config/mopidy/mopidy.conf
COPY entrypoint.sh /app/entrypoint.sh

RUN chmod 775 /app/entrypoint.sh

EXPOSE 6680
EXPOSE 1900/udp
EXPOSE 49152-49252

CMD ["sh", "-c", "/app/entrypoint.sh"]
