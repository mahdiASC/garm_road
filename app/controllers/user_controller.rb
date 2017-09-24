class UserController < ApplicationController
    get '/users' do
      erb :index
    end

    get "/signup" do
      if logged_in?
        redirect "/users/#{current_user.slug}"
      else
        erb :'users/signup'
      end
    end

    post "/signup" do
      user = User.create(params[:user])
      if user.save
        session[:user_id] = user.id
        redirect "/users/#{user.slug}"
      else
        redirect '/signup'
      end
    end

    get '/users/:slug' do
      if logged_in?
        @user_db = User.find_by_slug(params[:slug])
        erb :'users/show'
      else
        redirect '/login'
      end
    end

    get '/users/:slug/items' do
      if logged_in?
        @user_db = User.find_by_slug(params[:slug])
        @borrowed_items = Item.all.select{|item| item.current_possessor_user_id == @user_db.id}
        erb :'users/index'
      else
        redirect '/login'
      end
    end

    post '/users/:slug/edit' do

    end

    get "/login" do
      if logged_in?
        redirect "/users/#{current_user.slug}"
      else
        erb :'users/login'
      end
    end

    post "/login" do
      #username or email valid for logging in?
      user = User.find_by(:username=>params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/users/#{user.slug}"
      else
        redirect '/login?status=error'
      end
    end

    # get "/failure" do
    #
    #   erb :failure
    # end

    get "/logout" do
      session.clear
      redirect "/"
    end
    # log in
    # failure
    # logout
    # show any user's account details
    # edit account details

end
