class UserController < ApplicationController
    get '/users' do
      erb :index
    end

    get "/signup" do
      if logged_in?
        redirect "/users/#{current_user.slug}"
      else
        @user = User.new
        erb :'users/signup'
      end
    end

    post "/signup" do
      @user = User.create(params[:user])
      if @user.save
        session[:user_id] = @user.id
        redirect "/users/#{@user.slug}"
      else
        #assuming user invalid
        @failure_message = @user.errors.full_messages.join(', ')
        erb :'users/signup'
      end
    end

    get '/users/:slug' do
      authenticate_user
      @user_db = User.find_by_slug(params[:slug])
      if !@user_db
        redirect "/users/#{current_user.slug}"
      end
      erb :'users/show'
    end

    get '/users/:slug/items' do
      authenticate_user
      @user_db = User.find_by_slug(params[:slug])
      if !@user_db
        redirect "/users/#{current_user.slug}/items"
      end
      @borrowed_items = Item.all.select{|item| item.current_possessor_user_id == @user_db.id && item.user_id != @user_db.id}
      erb :'users/index'
    end


    get '/users/:slug/edit' do
      authenticate_user
      @user_db = User.find_by_slug(params[:slug])
      if @user_db==current_user
        erb :'users/edit'
      else
        session[:error] = "You do not have permission to edit that user's profile"
        redirect "/users/#{@user_db.slug}"
      end
    end

    post '/users/:slug' do
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
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/users/#{user.slug}"
      else
        session[:error] = "Invalid Login credentials"
        @username = params[:username]
        erb :'users/login'
      end
    end

    get "/logout" do
      session.clear
      redirect "/"
    end

end
