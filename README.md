# aws-ecs-web-app
[![jumal-ali](https://circleci.com/gh/jumal-ali/aws-ecs-web-app.svg?style=shield)](https://app.circleci.com/pipelines/github/jumal-ali/aws-ecs-terraform)

A Simple Hello World App Written in NodeJS

The application returns a simple "Hello World" message to the browser 

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

## Run Lint

This application uses eslint package

```sh
npm run lint
```