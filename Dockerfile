FROM node:18.13-alpine as build
WORKDIR /app
COPY ./package*.json ./

RUN npm ci
# RUN npm install

COPY ./ ./
RUN npm run build

FROM nginx:1.23.0-alpine
EXPOSE 8080
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/dist/ngcloudrun2 /usr/share/nginx/html