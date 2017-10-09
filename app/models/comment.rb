class Comment < ApplicationRecord
  belongs_to :post

  validates_presence_of :name, :email, :content, :post_id
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
end