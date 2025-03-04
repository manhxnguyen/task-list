#!/usr/bin/env bash
# exit on error
set -o errexit

# Install Ruby dependencies
bundle install

# If you're using a Free instance type, you need to
# perform database migrations in the build command.
# Uncomment the following line:

# Prepare database (creates if doesn't exist)
bundle exec rails db:prepare

# Run any pending migrations
bundle exec rails db:migrate

# Seed the database
# You might want to make this conditional for production
bundle exec rails db:seed