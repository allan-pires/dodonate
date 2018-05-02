# DoDonate
![dodo](https://i.imgur.com/Qx6aIEb.jpg)

[![CircleCI](https://circleci.com/bb/doislan/dodonate.svg?style=shield)](https://circleci.com/bb/doislan/dodonate)

![SimpleCov](https://bitbucket.org/doislan/dodonate/raw/master/coverage/coverage.svg?style=svg)

## About
DoDonate is a web application that helps people who want to donate something to find where they can donate it.

## How to setup
After cloning the project to your machine, navegate to dodonate directory and run the following commands:

```
docker-compose build
docker-compose exec web rake db:setup
```

## How to run
```
docker-compose up
```

## How to test
```
docker-compose exec web rspec
```

## Disclaimer
Illustrations by *Vecteezy.com*