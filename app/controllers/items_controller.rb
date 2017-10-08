class ItemController < ApplicationController
    get '/items' do
      authenticate_user
      erb :'items/index'
    end

    get '/items/new'do
      authenticate_user
      erb :'items/new'
    end

    get '/items/:id' do
      authenticate_user
      @item = Item.find_by(id: params[:id])
      if @item
        erb :'items/show'
      else
        #just in case item not properly accessed
        redirect '/items'
      end
    end

    post '/items' do
      authenticate_user
      item = Item.create(params[:item])
      if !item.id
        #id only found on correclty made items
        session[:error] = item.errors.full_messages.join(", ")
      end
      redirect "/users/#{current_user.slug}/items"
    end

    post '/items/:id/request' do
      #Will want to build this out with its own model and db
      #For now just changes the posessor to current_user
      @item = Item.find_by(id: params[:id])
      @item.current_possessor_user_id = current_user.id
      @item.save
      redirect "/items/#{params[:id]}"
    end

    get '/items/:id/new_review' do
      authenticate_user
      @item = Item.find_by(id: params[:id])
      erb :'items/new_review'
    end

    post '/items/:id/new_review' do
      authenticate_user
      if !params[:review].empty?
        Review.create(params[:review])
        redirect "items/#{params[:review][:item_id]}"
      else
        redirect "items/#{params[:review][:item_id]}/new_review"
      end
    end

    get '/items/:id/edit' do
      authenticate_user
      @item = Item.find_by(id: params[:id])
      if @item
        if @item.user == current_user
          erb :'items/edit'
        else
          session[:error]="Cannot alter items you do not own"
          redirect "/items/#{@item.id}"
        end
      else
        redirect "/item"
      end
    end

    patch '/items/:id/edit' do
      authenticate_user
      @item = Item.find_by(id: params[:id])
      if !@item.update(params[:item])
        session[:error] = "Could not update with invalid input"
      end
      redirect "/items/#{@item.id}"
    end

    delete '/items/:id/delete' do
      authenticate_user
      @item = Item.find_by(id: params[:id])
      @item.destroy
      redirect "/users/#{current_user.slug}/items"
    end
end
