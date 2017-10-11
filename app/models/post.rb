class Post < ApplicationRecord
	
	has_many :comments, dependent: :destroy
	
	validates_presence_of :title

	paginates_per 20

end