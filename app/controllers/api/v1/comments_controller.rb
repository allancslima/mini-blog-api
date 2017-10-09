class Api::V1::CommentsController < ApplicationController
	before_action :authenticate_post_with_id!

	def index
		comments = current_post.comments
		render json: { comments: comments }, status: 200
	end

	def show
		begin
			comment = current_post.comments.find(params[:comment_id])
			render json: comment, status: 200
		rescue
			head 404
		end
	end
end