require 'sqlite3'

class User
    def initialize
        @db = SQLite3::Database.new('db.sql')
        create_table_if_not_exists
    end

    def create(user_info) 
        sql = "INSERT INTO users (firstname, lastname, age, password, email) VALUES (?,?,?,?,?)"
        @db.execute(sql, user_info[:firstname], user_info[:lastname], user_info[:age], user_info[:password], user_info[:email])
        user_id = @db.last_insert_row_id
        return user_id
    end

    def find(user_id) #Use the given id to find a single user
        sql = "SELECT * FROM users WHERE id = ?"
        result = @db.execute(sql, user_id)
        if result.empty
            return nil
        else
            return user_hash(result[0]) #we have defined a method down below to turn our result into a hash
        end
    end

    def all #get all users from the DB
        sql = "SELECT * FROM users"
        results = @db.execute(sql)
        users = {}
        results.each do |row|
            user = user_hash(row)
            users[user[:id]] = user
        end
        return users
    end

    def update(users_id, attribute, value)
        sql = "UPDATE users SET #{attribute} = ? WHERE id =?"
        @db.execute(sql, value, user_id)
        return find(user_id)
    end

    def destroy(user_id)
        sql = "DELETE FROM users WHERE id =?"
        @db.execute(sql, user_id)
    end

    private

    def create_table_if_not_exists
        sql = "CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY AUTOINCREMENT, firstname TEXT, lastname TEXT, age INTEGER, password TEXT, email TEXT)"
        @db.execute(sql)
    end

    def user_hash(row)
        user ={
            id:row[0],
            firstname: row[1],
            lastname: row[2],
            age: row[3],
            password: row[4],
            email: row[5]
        }

        return user
    end
end
