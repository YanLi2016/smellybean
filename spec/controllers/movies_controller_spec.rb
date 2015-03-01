require 'spec_helper'

describe MoviesController do 
	describe "find similar movies " do 
		before :each do
			@movie = double('movie1')
			@movienodir = double('movie')
			@movienodir.stub!(:director).and_return(nil)
			@movienodir.stub!(:title).and_return(nil)
			@movie.stub(:director).and_return("hey")
			@fake_results = [double('movie1'), double('movie2')]
		end
		it "should have a the RESTful route .. use match, when i click 'Find with Same Director'" do
            Movie.should_receive(:find).with('1').and_return(@movie)
			get :show_director, {:id => "1"}
			response.should render_template('show_director')
  		end
		
		it "should find all the movies with the same director " do 
		    Movie.should_receive(:find).with('1').and_return(@movie)
		    @movie.should_receive(:director).and_return("hey")
		    Movie.should_receive(:find_all_by_director).with('hey').and_return(@fake_results)
			get :show_director, {:id => "1"}
		end 

		it "should have a sad path" do 
			Movie.should_receive(:find).with('1').and_return(@movienodir)
			get :show_director, {:id => "1"}
	        response.should redirect_to(movies_path)
	    end 
	end 
end 