# DoDonate
![dodo](https://i.imgur.com/s5o07Bv.png)

![SimpleCov](https://github.com/doisLan/dodonate/blob/master/coverage/coverage.svg)

## About
DoDonate is a web application that helps people who want to donate something to find where they can donate it.

## How to Setup
After cloning the project to your machine, navegate to dodonate directory and run the following commands:

```
docker-compose build
docker-compose run web rake db:setup
```

## How to Run
```
docker-compose up
```
Now you just have to access http://localhost:3000 and that's it!

## How to Test
```
docker-compose run web bundle exec rspec
```

## API Docs
https://documenter.getpostman.com/view/2110594/dodonate/RW1hiGXe

## Disclaimer
Illustration by Stevan Rodic
