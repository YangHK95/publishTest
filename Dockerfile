FROM node:19 AS build

WORKDIR /app

COPY package.json .

RUN npm i

COPY ./ ./

RUN npm run build

FROM nginx:1.18.0

RUN rm /etc/nginx/conf.d/default.conf

COPY config/default.conf /etc/nginx/conf.d/

COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]