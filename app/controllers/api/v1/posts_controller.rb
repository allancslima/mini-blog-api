class Api::V1::PostsController < ApplicationController
	def index
		posts = Post.all
		render json: { posts: posts }, status: 200 
	end

	def show
		begin
			post = Post.find(params[:id])
			render json: post, status: 200
		rescue
			head 404
		end
	end

	def create
		post = Post.new(post_params)
		
		if post.save
			render json: post, status: 201
		else
			render json: { errors: post.errors }, status: 422
		end
	end

	def update
		post = Post.find(params[:id])
		
		if post.update_attributes(post_params)
			render json: post, status: 200
		else
			render json: { errors: post.errors }, status: 422
		end
	end

	private

	def post_params
		params.require(:post).permit(:title, :content)
	end
end