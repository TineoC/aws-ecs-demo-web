FROM node:20-alpine3.19 as BUILD

WORKDIR /app

COPY package.json package*.json /

RUN npm ci --silent

COPY . .

RUN npm run build

FROM nginx:alpine as PUBLISH

COPY --from=BUILD /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
