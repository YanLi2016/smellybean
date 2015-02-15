class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  
  def index
    @new_order = params[:order].present?
    @new_filter = params[:ratings].present?
    @session_order = session[:order].present?
    @session_ratings = session[:ratings].present?
    @all_ratings = Movie.all_ratings
    @redirect = false 
   
    if @new_order
      session[:order] = params[:order]
    elsif @session_order
      redirect = true 
    end 
    
    if session[:ratings] == nil
      session[:ratings] = @all_ratings
      # @order = Hash.new()
      # @all_ratings.each{|rating| @order[rating] = 1}
      # session[:ratings] = @order
    elsif @new_filter 
      session[:ratings] = params[:ratings].keys
    elsif @session_ratings
      redirect = true 
    end 
    @checked = session[:ratings]
    @order = session[:order]
    if redirect
      @checked = session[:ratings]
      redirect_to(movies_path(:order => session[:order], :ratings => session[:ratings]))
    end 
    @movies = Movie.order(session[:order])
    @movies =  @movies.find_all_by_rating(@checked) 
    # end 
    
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
