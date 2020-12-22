class AuctionsController < ApplicationController

    get '/auctions' do
      @auctions = Auction.all
      erb :'/auctions/auctions'
    end
  
    post '/auctions' do
      @auction = current_user.auctions.new(title: params[:title], start_date: params[:start_date], end_date: params[:end_date])
      if @auction.save
        redirect to "/auctions/#{@auction.slug}"
      else
        redirect to '/auctions/new'
      end
    end
  
    get '/auctions/new' do
      if logged_in?
        erb :'/auctions/create_auction'
      else
        redirect to '/'
      end
    end
  
    get '/auctions/:id' do
      @auction = Auction.find(params[:id])
      erb :'/auctions/show_auction'
    end
  
    get '/auctions/:id/edit' do
      @auction = Auction.find_by_id(params[:id])
      if logged_in? && current_user.auctions.include?(@auction)
        erb :'/auctions/edit_auction'
      else
        redirect to "/auctions/#{@auction.id}"
      end
    end
  
    patch '/auctions/:id' do
      @auction = Auction.find_by_id(params[:id])
      @auction.title = params[:title]
      @auction.start_date = Date.parse(params[:start_date])
      @auction.end_date = Date.parse(params[:end_date])
      if logged_in? && current_user.auctions.include?(@auction) && @auction.valid?
        @auction.save
        redirect to "/auctions/#{@auction.id}"
      else
        redirect to "/auctions/#{@auction.title}"
      end
    end
  
    delete '/auctions/:slug' do
      @auction = Auction.find_by_slug(params[:slug])
      if logged_in? && current_user.auctions.include?(@auction)
        @auction.guitars.each do |guitar|
          guitar.delete
        end
        @auction.delete
        redirect to "/users/#{current_user.id}"
      else
        redirect to "/auctions/#{@auction.slug}"
      end
    end
  end