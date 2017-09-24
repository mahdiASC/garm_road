class ItemController < ApplicationController
    # get '/items' do
    #   erb :index
    # end

    get '/items' do
      if logged_in?
        erb :'items/index'
      else
        redirect "/login"
      end
    end

    #view all items (contains reviews)
    #view all items in user's location
    #view 1 item
    #create new item
    #edit 1 item (users)
    #delete 1 item (users)

end
