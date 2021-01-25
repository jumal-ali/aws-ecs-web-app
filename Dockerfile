FROM node:12-alpine AS dependencies

LABEL author="Jumal Ali"

WORKDIR /build

COPY package*.json .
RUN npm install && npm cache clean --force --loglevel=error

# -----------------

FROM node:12-alpine

LABEL author="Jumal Ali"

RUN apk add --no-cache tini curl

WORKDIR /app

RUN addgroup -S www && adduser -S www -G www
COPY --chown=www:www --from=dependencies /build/node_modules /app/node_modules
COPY --chown=www:www /src .
USER www

EXPOSE 3000

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["node","server.js"]