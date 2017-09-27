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
        erb :failure
        # redirect '/signup'
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
        @borrowed_items = Item.all.select{|item| item.current_possessor_user_id == @user_db.id && item.user_id != @user_db.id}
        erb :'users/index'
      else
        redirect '/login'
      end
    end


    get '/users/:slug/edit' do
      if logged_in?
        @user_db = User.find_by_slug(params[:slug])
        if @user_db==current_user
          erb :'users/edit'
        else
          session[:error] = "You do not have permission to edit that user's profile"
          redirect "/users/#{@user_db.slug}"
        end
      else
        redirect '/login'
      end
    end

    post '/users/:slug/edit' do
      if params[:user][:password].empty?
        params[:user].delete('password')
      end

      user = User.find_by_slug(params[:slug])
      params[:user].each do |key,value|
        user.update_attribute(key.to_s, value)
      end
      redirect "/users/#{params[:slug]}"
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
      # binding.pry
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/users/#{user.slug}"
      else
        session[:error] = "Invalid Login credentials"
        redirect '/login'
      end
    end

    get "/logout" do
      session.clear
      redirect "/"
    end

end
