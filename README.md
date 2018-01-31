# Skrol Basic

This is the Skrol Basic App for Language Acquisition.

* Ruby version
  ruby 2.3.1p112 (2016-04-26 revision 54768) [x86_64-darwin16]

* System dependencies
  huh?

* Configuration
  huh?

* Database creation
  $ heroku run rake db:setup

* Database initialization
  $ heroku run rake db:schema:load

* Database Restart
  $ pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start
  $ pg_ctl -D /usr/local/var/postgres stop -s -m fast

* How to run the test suite
  rails test

* Services (job queues, cache servers, search engines, etc.)
  none yet.

* Deployment instructions
  $ git push heroku master

* Course Pipe Line
- Create Languages and Scripts (English first)
- Send sentence and word pairs through the api.
- Run SentenceSplitter on all standard scripts.
- Run SentenceWordUpdater for all standard scripts.
- Run BingWordAssign on all standard scripts.
- Run PhoneticJoiner on all standard scripts.
- Run the LanguageMapConsolidator for all LanguageMaps.
- Run the CourseCreator for all applicable LanguageMaps.
- Run 'update_to_latest_course' method on all Enrolments.
  or
- Run 'create_enrolments' if new LanguageMap.
