class Movie < ActiveRecord::Base
  attr_accessible :title, :rating, :description, :release_date, :director
  def self.all_ratings ; %w[G PG PG-13 R] ; end
end
