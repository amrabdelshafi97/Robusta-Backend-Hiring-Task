# Robusta-Backend-Hiring-Task
**Ruby on Rails - Technical Task For Robusta Hiring, It's a simple movie app**
## Features Our App Offers
* CRUD operations for(movies/celebrities/Genres/...)
* Manual registering and with Facebook
* Search at Movies, Celebrities, News
## User Storiers
* Initialize RoR app
* Design the ERD
* Create the database which is postgres and apply the ERD we already created
* Implement the Crud operations
* Write Unit Tests
* Add elasticsearch for best searching performance
* Add ActiveAdmin to ease the crud operations for the admin through a friendly user interface
* Create docker-compose for running needed tools
### At first there are some steps we should take in order to run the app correctly:
`bundle install` to install all the needed gems
`rails s` to run rails server
`docker-compose up -d` to pull postgres and elasticseach images and run their containers
here to create admin panel credentials.
```
rails c
AdminUser.create!(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password')
```
open `http://localhost:3000/admin` at your browser, so you can input data from admin panel.
In order to run elasticsearch you need to run these commands at Ruby console, for the following models:
```
 rails c
 Celebrity.__elasticsearch__.create_index
 Celebrity.import
 Movie.__elasticsearch__.create_index
 Movie.import
 News.__elasticsearch__.create_index
 News.import
```
And for MailingService and facebook authentication you need to add your own enviroment variables by adding `config/application.yml`, example: 
```
SMTP_USERNAME_DEV: "example@domain.com"
```

