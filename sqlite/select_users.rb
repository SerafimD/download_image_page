require 'sqlite3'

module Sqlite
  class SelectUsers

    def initialize
      @db = SQLite3::Database.new'db.sqlite3'
    end

    def execute
      sql = 'SELECT email, count(message) FROM Users LEFT JOIN Messages
             ON Messages.user_id = Users.id
             GROUP BY email, message
             ORDER BY count(message) DESC
             LIMIT 10;'
      @db.execute sql do |row|
        puts row
      end
    end

  end
end