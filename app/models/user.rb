require 'bcrypt'
require 'data_mapper'
require 'dm-postgres-adapter'
require 'dm-migrations'

class User
  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :email, String
  property :username, String
  property :password_encrypt, Text

  def password=(password)
    self.password_encrypt = BCrypt::Password.create(password)
  end
end

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/chitter_#{ENV['RACK_ENV']}")
DataMapper.finalize
DataMapper.auto_upgrade!