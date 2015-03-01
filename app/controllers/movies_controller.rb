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
      @init_hash = Hash.new()
      @all_ratings.each{|rating| @init_hash[rating] = 1}
      session[:ratings] = @init_hash  
    elsif @new_filter   
      session[:ratings] = params[:ratings]     
    elsif @session_ratings
      redirect = true 
    end 
    if redirect
      flash.keep
      redirect_to(movies_path(:order => session[:order], :ratings => session[:ratings]))
    else 
      @checked = session[:ratings].keys 
      @order = session[:order]
      @movies = Movie.order(session[:order])
      @movies =  @movies.find_all_by_rating(@checked) 
    end    
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

  def show_director 
    @movie = Movie.find(params[:id])
    @director = @movie.director
    if @director.nil? || @director.empty?
      flash[:notice] = "'#{@movie.title}' has no director info."
      redirect_to movies_path 
    else 
      # @director = @movie.director
      @movies = Movie.find_all_by_director(@director) 
    end 
  end 
end
