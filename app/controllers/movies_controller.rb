class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    #@movies = Movie.all
    @all_ratings = Movie.all_ratings 
    if(params[:ratings]!=nil)
    	@selected_ratings = params[:ratings]
    else
    	@selected_ratings = session[:current_ratings]
    end
    if(params[:sort]!=nil)
    	@sort_by = params[:sort]
    else
      @sort_by = session[:current_sort]
    end  
    if(@sort_by == "title")
     	if(@selected_ratings == nil)
    		@movies = Movie.order("title ASC")
    	else
    		@movies = Movie.where(:rating => @selected_ratings.keys).order("title ASC")
    	end
    	@sort_title = "hilite"
    	@sort_release_date = ""
    elsif(@sort_by == "release_date")
     	if(@selected_ratings == nil)
    		@movies  = Movie.order("release_date ASC")
    	else
    		@movies = Movie.where(:rating => @selected_ratings.keys).order("release_date ASC")
    	end
    	@sort_title = ""
    	@sort_release_date = "hilite"
    else
    	if(@selected_ratings == nil)
    		@movies = Movie.all
    	else
    		@movies = Movie.where(:rating => @selected_ratings.keys)
    	end
    	@sort_title = ""
    	@sort_release_date = ""
    end
    
    session[:current_sort] = @sort_by
    session[:current_ratings] = @selected_ratings
    
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
