class ItemController < ApplicationController
    get '/items' do
      if logged_in?
        erb :'items/index'
      else
        redirect "/login"
      end
    end

    get '/items/new'do
      if logged_in?
        erb :'items/new'
      else
        redirect "/login"
      end
    end

    get '/items/:id' do
      if logged_in?
        @item = Item.find(params[:id])
        erb :'items/show'
      else
        redirect "/login"
      end
    end

    post '/items' do
      item = Item.create(params[:item])
      if !item.save
        session[:error] = "Could not create Item: Invalid input"
      end
      redirect "/users/#{current_user.slug}/items"
    end

    post '/items/:id/request' do
      #Will want to build this out with its own model and db
      #For now just changes the posessor to current_user
      @item = Item.find(params[:id])
      @item.current_possessor_user_id = current_user.id
      @item.save
      redirect "/items/#{params[:id]}"
    end

    get '/items/:id/new_review' do
      if logged_in?
        @item = Item.find(params[:id])
        erb :'items/new_review'
      else
        redirect "/login"
      end
    end

    post '/items/:id/new_review' do
      if !params[:review].empty?
        Review.create(params[:review])
        redirect "items/#{params[:review][:item_id]}"
      else
        redirect "items/#{params[:review][:item_id]}/new_review"
      end
    end

    get '/items/:id/edit' do
      if logged_in?
        @item = Item.find(params[:id])
        if @item.user == current_user
          erb :'items/edit'
        else
          session[:error]="Cannot alter items you do not own"
          redirect "/items/#{@item.id}"
        end
      else
        redirect "/login"
      end
    end

    patch '/items/:id/edit' do
      @item = Item.find(params[:id])
      if !@item.update(params[:item])
        session[:error] = "Could not update with invalid input"
      end
      redirect "/items/#{@item.id}"
    end

    delete '/items/:id/delete' do
      @item = Item.find(params[:id])
      @item.destroy
      redirect "/users/#{current_user.slug}/items"
    end
end
