FROM node
RUN apt-get update && apt-get install -y \
    curl nginx \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY package.json /app
COPY index.js /app
COPY nginx/nginx.conf /etc/nginx/
RUN npm install
EXPOSE 80
CMD [ "npm", "start" ]