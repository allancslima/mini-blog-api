class Api::V1::CommentsController < ApplicationController
	
	before_action :confirm_post_with_id!

	def index
		comments = current_post.comments
		render json: { comments: comments }, status: 200
	end

	def show
		begin
			comment = current_post.comments.find(params[:id])
			render json: comment, status: 200
		rescue
			head 404
		end
	end

	def create
		comment = current_post.comments.build(comment_params)
		
		if comment.save
			render json: comment, status: 201
		else
			render json: { errors: comment.errors }, status: 422
		end
	end

	def update
		comment = current_post.comments.find(params[:id])
		
		if comment.update_attributes(comment_params)
			render json: comment, status: 200
		else
			render json: { errors: comment.errors }, status: 422
		end
	end

	def destroy
		comment = current_post.comments.find(params[:id])
		comment.destroy
		head 204
	end

	private

	def comment_params
		params.require(:comment).permit(:name, :email, :body)
	end
	
end