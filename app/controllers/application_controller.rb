require './config/environment'
class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "keanu"
    end

    get '/' do
        erb :index
    end

    #annoying chrome
    get "/favicon.ico" do
    end


  helpers do
    def logged_in?
      !!current_user
    end

    def current_user # => User Object or nil
      # momoization
      # Saving calls to DB
      # if @current_user
      #   @current_user
      # else
      #   @current_user = User.find_by(id: session[:user_id]) if session[:user_id]
      # end
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end
  end

  private

    def authenticate_user
      if !logged_in?
        redirect "/login"
      end
    end
end
