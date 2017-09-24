class AccountController < ApplicationController
    get '/account' do
      erb :index
    end

    get "/signup" do
      if logged_in?
        redirect "/account/#{current_user.slug}"
      else
        erb :'account/signup'
      end
    end

    post "/signup" do
      user = User.create(params[:user])
      if user.save
        session[:user_id] = user.id
        redirect "/account/#{user.slug}"
      else
        redirect '/signup'
      end
    end

    get '/account/:slug' do
      if logged_in?
        @user_db = User.find_by_slug(params[:slug])
        erb :'account/index'
      else
        redirect '/login'
      end
    end

    get "/login" do
      if logged_in?
        redirect "/account/#{current_user.slug}"
      else
        erb :'account/login'
      end
    end

    post "/login" do
      #username or email valid for logging in
      user = User.find_by(:username=>params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/account/#{user.slug}"
      else
        redirect '/failure'
      end
    end

    get "/failure" do
      erb :failure
    end

    get "/logout" do
      session.clear
      redirect "account/login"
    end
    # log in
    # failure
    # logout
    # show any user's account details
    # edit account details

end
