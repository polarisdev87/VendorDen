# README

## Development Setup

1. Copy the database configuration and enter your local credentials

   <code>RAILS_ROOT$ cp config/database.yml.sample config/database.yml</code>

2. Copy the environment variables configuration and enter appropriate values (please ask for development values)

   <code>RAILS_ROOT$ cp .env.sample .env</code>

3. Initialize and migrate your local database

   <code>RAILS_ROOT$ rails db:create db:migrate</code>

4. Install Heroku CLI https://devcenter.heroku.com/articles/heroku-cli

5. Run the server

   <code>RAILS_ROOT$ heroku local</code>

6. Install ngrok [https://ngrok.com/] at RAILS_ROOT folder

6. Run ngrok

   <code>RAILS_ROOT$ ngrok https 3000</code>

7. Set the SHOPIFY_APP_HOST environment variable in .env with the ngrok generated host

8. Make sure to run the test before commiting your code

   <code>RAILS_ROOT$ bundle exec rspec</code>

9. Do not commit changes to db/schema.rb if you dont have a migration that changes the schema e.g. adding columns to table or create new table

10. Happy developing! :)

