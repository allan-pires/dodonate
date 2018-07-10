# DoDonate
![dodo](https://i.imgur.com/s5o07Bv.png)

[![CircleCI](https://circleci.com/gh/doisLan/dodonate.svg?style=svg)](https://circleci.com/gh/doisLan/dodonate)

![SimpleCov](https://cdn.rawgit.com/doisLan/dodonate/master/coverage/coverage.svg)

## About
DoDonate is a web application that helps people who want to donate something to find where they can donate it.

## How to setup
After cloning the project to your machine, navegate to dodonate directory and run the following commands:

```
docker-compose build
docker-compose run web rake db:setup
```

## How to run
```
docker-compose up
```
Now you just have to access http://localhost:3000 and that's it!

## How to test
```
docker-compose run web bundle exec rspec
```

## API Docs
https://documenter.getpostman.com/view/2110594/dodonate/RW1hiGXe

## Disclaimer
Illustration by Stevan Rodic
