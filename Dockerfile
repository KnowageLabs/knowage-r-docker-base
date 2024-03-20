FROM r-base:4.1.3

WORKDIR /app

COPY LICENSE ./

RUN apt-get update \
	&& apt-get install --no-install-recommends -y libssl-dev file libcurl4-openssl-dev libsodium-dev \
	&& rm -rf /var/lib/apt/lists/* \
	&& r -e "install.packages('plumber')" \
	&& r -e "install.packages('base64enc')" \
	&& r -e "install.packages('jose')"

RUN useradd -M -r knowage \
	&& chown -R knowage:knowage /app

USER knowage
