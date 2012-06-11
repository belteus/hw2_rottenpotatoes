class Movie < ActiveRecord::Base
	def self.all_ratings
		a = Array.new
		select("rating").each do |r|
			if(!a.include?(r.rating))
				a.push r.rating
			end
		end
		return a
	end
end
