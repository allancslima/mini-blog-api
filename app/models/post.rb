class Post < ApplicationRecord
	validates_presence_of :title

	has_many :comments, dependent: :destroy

	paginates_per 20
end