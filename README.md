# DoDonate
![dodo](https://i.imgur.com/s5o07Bv.png)

[![CircleCI](https://circleci.com/bb/doislan/dodonate.svg?style=shield)](https://circleci.com/bb/doislan/dodonate)

![SimpleCov](https://bitbucket.org/doislan/dodonate/raw/master/coverage/coverage.svg?style=svg)

## About
DoDonate is a web application that helps people who want to donate something to find where they can donate it.

## How to setup
After cloning the project to your machine, navegate to dodonate directory and run the following commands:

```
docker-compose build
docker-compose run web rake db:migrate
```

## How to run
```
docker-compose up
```

## How to test
```
docker-compose run web bundle exec rspec
```

## Disclaimer
Illustration by Stevan Rodic