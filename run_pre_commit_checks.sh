#!/bin/bash

# Script for running various pre-commit checks for a Ruby on Rails project.

printf  "\n== RUNNING BUNDLER-AUDIT ==\n\n"
bundle exec bundle-audit --update
sleep 3

printf  "\n== RUNNING BRAKEMAN ==\n"
bundle exec brakeman -A -q --summary
sleep 3

printf  "== RUNNING DATABASE-CONSISTENCY ==\n\n"
bundle exec database_consistency -f
sleep 3

printf  "\n== RUNNING RUBOCOP ==\n\n"
bundle exec rubocop -a
sleep 3

printf  "\n== RUNNING TESTS ==\n\n"
bundle exec rails test
sleep 3

printf  "\n== RUNNING CLEANING ==\n\n"
bundle exec rails assets:clobber tmp:clear log:clear
printf "Done cleaning\n"

printf  "\n== ALL CHECKS DONE! ==\n\n"
