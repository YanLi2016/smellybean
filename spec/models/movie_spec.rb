require 'spec_helper'

describe Movie do 
	before :each do
		@movie = double('movie1')
		@movie.stub(:director).and_return("hey")
		@fake_results = [double('movie1'), double('movie2')]
	end
end 
