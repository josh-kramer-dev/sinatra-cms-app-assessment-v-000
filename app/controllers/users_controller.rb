class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/notes'
    else
      erb :'/users/signup'
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:password].empty? || params[:email].empty?
      redirect '/signup/error'
    end

    if !User.find_by(:username => params[:username])
      @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
      session[:user_id] = @user.id
      redirect '/login'
    else
      redirect '/signup/error'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/notes'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    if params[:username].empty? || params[:password].empty?
      redirect '/login/error'
    end
    @user = User.find_by(username: params[:username])
    session[:user_id] = @user.id
    if @user && @user.authenticate(params[:password])
      redirect '/notes'
    else
      redirect '/login/error'
    end
  end

  get '/signup/error' do
    erb :'/users/signup_error'
  end

  get '/login/error' do
    erb :'/users/login_error'
  end

  get '/logout' do
    logout!
    redirect '/'
  end

end
