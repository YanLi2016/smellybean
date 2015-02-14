class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    
    @order = params[:order]
    # @movies = Movie.order(params[:order])
    # Movies.order(params[:order]).find_all_by_rating(@checked.keys)
    # @all_ratings = Movie.uniq.pluck(:rating)
    @all_ratings = Movie.all_ratings
    # @checked = Movie.all_ratings
    @checked = (params[:ratings].present? ? params[:ratings] : @all_ratings)
    @movies = Movie.order(params[:order])
    @movies = (params[:ratings].present? ? @movies.find_all_by_rating(@checked.keys) : @movies)

    # @movies = (params[:order].present? ? @movi.sort_by {'&:' + params[:order]} : @movi )
      # @movies = Movie.all
    # end 


    # @movies = Movie.all
  end

  def new
    # default: render 'new' template
    # @checked = Movie.all_ratings
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
