# This script configures the database connection for an ActiveRecord-based application.
# It requires the 'active_record' and 'sqlite3' gems.
# The connection is established using SQLite3 as the database adapter and specifies the database file location.
require 'active_record'
require 'sqlite3'

puts "RACK_ENV is: #{ENV['RACK_ENV']} (default: development)"

env = ENV['RACK_ENV'] || 'development'
puts "Connecting to #{env} database..."

# Configuration for database connections.
# 
# This hash contains settings for different environments:
# - 'development': Uses SQLite3 with a database file located at 'db/snippets.db'.
# - 'test': Uses SQLite3 with a database file located at 'db/test.db'.
#
# Each environment configuration includes:
# - `adapter`: The database adapter to use (e.g., 'sqlite3').
# - `database`: The path to the database file.
db_config = {
  'development' => {
    adapter: 'sqlite3',
    database: 'db/snippets.db'
  },
  'test' => {
    adapter: 'sqlite3',
    database: 'db/test.db'
  },
}

ActiveRecord::Base.establish_connection(db_config[env])