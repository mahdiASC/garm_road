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
end