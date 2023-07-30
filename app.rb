require 'sinatra'
require 'json'
require_relative 'my_user_model.rb'
require 'erb'

enable :sessions
set :views, File.join(settings.root, 'views')
set :port, 8080

get '/' do
    @users = User.new.all.map {|id, user| user.delete(:password); user}
    @users
    erb:index
end

get '/users' do
    users = User.new.all.map {|id, user| user.delete(:password); user}
    users.to_json
end

post '/users' do
    user_info = {
        firstname: params[:firstname],
        lastname: params[:lastname],
        age: param[:age],
        password: params[:password],
        email: params[:email]
    }
    user_id = User.new.create(user_info)
    user = User.new.find(user_id)
    user.delete(:password)
    user.to_json
end

post '/sign_in' do
    email = params[:email]
    password = params[:password]
    user = User.new.all.values.find{|u| u[:email] == email && u[:password] == password}
    if user
        session[:user_id] = user[:id]
        user.delete(:password)
        user.to_json
    else
        halt 401, {error: 'Wrong email or password'}.to_json
    end
end

put '/users' do
    user_id = session[:user_id]
    if user_id
        new_password = params[:password]
        User.new.update(user_id, 'password', new_password)
        user = User.new.find(user_id)
        user.delete(:password)
        user.to_json
    else
        halt 401, {error: 'Not authorized'}.to_json
    end
end

delete '/sign_out' do
    session.delete(:user_id)
    status 204
end

delete '/users' do
    user_id = session[:user_id]
    if user_id
        User.new.destroy(user_id)
        session.delete(:user_id)
        status 204
    else
        halt 401, {error: 'Not authorized'}.to_json
    end
end
