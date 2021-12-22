FROM node:16.5.0-alpine as builder

WORKDIR /usr/src/app


ENV PATH /usr/src/app/node_modules/.bin:$PATH


COPY package.json .
COPY package-lock.json .
RUN npm ci


COPY . .
RUN npm run build

FROM nginx:1.19.4-alpine


RUN rm -rf /etc/nginx/conf.d
COPY conf /etc/nginx


COPY --from=builder /usr/src/app/build /usr/share/nginx/html

# expose port
EXPOSE 80

# run nginx
CMD ["nginx", "-g", "daemon off;"]