class ItemController < ApplicationController
    get '/items' do
      erb :index
    end

    #view all items (contains reviews)
    #view all items in user's location
    #view 1 item
    #create new item
    #edit 1 item (users)
    #delete 1 item (users)

end
