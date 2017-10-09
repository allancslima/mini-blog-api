class Comment < ApplicationRecord
  belongs_to :post

  validates_presence_of :name, :email, :content, :post_id
end