class GuitarsController < ApplicationController


    get '/guitars' do
        if logged_in?
        @guitars = Guitar.all
            erb :'/guitars/guitars'
        else
            redirect to '/login'
        end
    end  


    get '/guitars/new' do
      if logged_in?
        erb :'/guitars/create_guitar'
      else
        redirect to '/'
      end
    end
  
    post '/guitars' do
      @guitar = Guitar.new(auction: Auction.find_or_create_by(title: params[:auction][:title], user_id: current_user.id),             
      brand: params[:brand].strip,
      model: params[:model].strip,
      year: params[:year].strip,
      price: params[:price].to_f)
      if @guitar.save && @guitar.auction.valid?
        redirect to "/guitars/#{@guitar.id}"
      else
        redirect to '/guitars/new'
      end
    end
  
    get '/guitars/:id' do
      @guitar = Guitar.find_by_id(params[:id])
      erb :'/guitars/show_guitar'
    end
  
    get '/guitars/:id/edit' do
      @guitar = Guitar.find_by_id(params[:id])
      if logged_in? && current_user.guitars.include?(@guitar)
        erb :'/guitars/edit_guitar'
      else
        redirect to "/guitars/#{@guitar.id}"
      end
    end
  
    patch '/guitars/:id' do
      @guitar = Guitar.find_by_id(params[:id])
      @guitar.brand = params[:brand]
      @guitar.model = params[:model]
      @guitar.year = params[:year]
      @guitar.price = params[:price]
      if logged_in? && current_user.guitars.include?(@guitar)
        @guitar.save
        redirect to "/guitars/#{@guitar.id}"
      else
        redirect to "/guitars/#{@guitar.id}"
      end
    end
  
    delete '/guitars/:id' do
      @guitar = Guitar.find_by_id(params[:id])
      if logged_in? && current_user.guitars.include?(@guitar)
        @guitar.delete
        redirect to "/users/#{current_user.id}"
      else
        redirect to "/guitars/#{@guitar.id}"
      end
    end
  end