# aws-ecs-web-app
[![jumal-ali](https://circleci.com/gh/jumal-ali/aws-ecs-web-app.svg?style=shield)](https://app.circleci.com/pipelines/github/jumal-ali/aws-ecs-web-app)

A Simple Hello World App Written in NodeJS

The application returns a simple "Hello World" response

Logs are sent to stdout in http access log format

## Run Locally

Run the following commands

```sh
npm install --save
npm start
```

then visit: http://localhost/3000 from your browser

## Start Docker Dev Envionment 

```sh
make start-dev-env
```

## Lint changes

This application uses eslint package

```sh
npm run lint
```
