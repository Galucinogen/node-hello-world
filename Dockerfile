FROM node
RUN apt-get update && apt-get install -y \
    curl nginx supervisor net-tools \
    && rm -rf /var/lib/apt/lists/*

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log \

WORKDIR /app
COPY package.json /app
COPY index.js /app
COPY files/nginx.conf /etc/nginx/
COPY files/supervisord.conf /etc/supervisord.conf
RUN npm install
EXPOSE 80

CMD ["supervisord", "-c", "/etc/supervisord.conf"]
