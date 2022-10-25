FROM node
RUN apt-get update && apt-get install -y \
    curl nginx supervisor net-tools \
    && rm -rf /var/lib/apt/lists/*

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

RUN adduser nginx --disabled-password --gecos "nginx" --no-create-home
RUN mkdir -p /app
WORKDIR /app
COPY package.json .
COPY index.js .
COPY files/nginx.conf /etc/nginx/
COPY files/supervisord.conf /etc/supervisord.conf
RUN npm install
EXPOSE 80

CMD ["supervisord", "-c", "/etc/supervisord.conf"]
