require 'active_record'

#connect to database
options = {
  adapter: 'postgresql',
  database: 'poochfind',
}

#ActiveRecord::Base.establish_connection(options)
ActiveRecord::Base.establish_connection( ENV['DATABASE_URL'] || options)
