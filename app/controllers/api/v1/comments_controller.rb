class Api::V1::CommentsController < ApplicationController
	before_action :authenticate_post_with_id!

	def index
		comments = current_post.comments
		render json: { comments: comments }, status: 200
	end

end