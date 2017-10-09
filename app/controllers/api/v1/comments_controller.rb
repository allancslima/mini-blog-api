class Api::V1::CommentsController < ApplicationController
	before_action :validate_post_with_id!

	def index
		comments = current_post.comments
		render json: { comments: comments }, status: 200
	end

	def current_post
		@current_post ||= Post.find_by(id: params[:post_id])
	end

	def validate_post_with_id!
		render json: { errors: 'Post does not exist' }, status: 404 unless existing_post?
	end

	def existing_post?
		current_post.present?
	end

end