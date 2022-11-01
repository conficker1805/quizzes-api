# ANDPAD ASSIGNMENT

## What did I do?
- Create a RoR API for Quizzes (Rails v7.0.4, ruby-3.1.0)
- Endpoint to sign in a user (JWT)
- Endpoint to fetch list of domain
- Endpoint to start doing an assessment
- Endpoint to submit answers and return user's score
- Add API documentation (Swagger)
- Add Unit Test (coverage 100%)
- Dockerize Rails app
- Build CI pipeline with Github actions

[DEMO API & MOCKUP](#demo)

## Further development
- Admin UI to create/manage Quizzes
- UI for users doing/submitting an assessment
- Cloud deployment

## Details

*This assignment focus on how I structure the Rails app and classes, models, implementing unit test and coding style. Not focus on high-level/new technologies.*

**Requirement**
- Non-login users can login to the system. (email: `user@example.com`, password: `your_password` )
- Non-login users can view list of Domains (the field that the user wants to do an assessment on)
- Authentication is required if user to start doing an assessment or submit their answers for an assessment
- User have to submit the answer for 5 quizzes in 5 minutes since the assessment started
- Validate and return errors for illegal submission (cheating, timeout...)
- Expire the assessment if user started doing it but never submitted their answer
- User can not do multiple assessments at the same time

## Best practices
- Follow ruby coding style guide (validated by Rubocop)
- Query object
- Service object
- Feature extraction
- Factory pattern
- DRY
- KISS
- SOLID


## Usage
**Docker users**

Set ENV (rails credentials) by renaming `development.key.sample` to `development.key` in `config/credentials`
```
cp config/credentials/development.key.sample config/credentials/development.key
cp config/credentials/test.key.sample config/credentials/test.key
```
*In the scope of the test, we public the `development.key` instead of sharing it privately.*

Start docker containers
```
docker-compose build
docker-compose up
```

Create database
```
docker-compose run api bundle exec rails db:create db:migrate db:seed
```

Running rspec
```
docker-compose run api bundle exec rspec
```

**Normal users**

Install redis
```
brew install redis
redis-server
```

Install ruby-3.1.0
```
rvm install "ruby-3.1.0"
```

```
bundle install
```

```
rake db:create db:migrate db:seed
```

```
rails s
```

**Testing**

API testing [Swagger](http://localhost:3000/api-docs/index.html)

## Demo
[![Watch the video](https://nintendo-power.com/wp-content/uploads/2022/02/1644902932_How-to-download-YouTube-video-to-your-computer.jpg)](https://youtu.be/TdHKShURXRc)

