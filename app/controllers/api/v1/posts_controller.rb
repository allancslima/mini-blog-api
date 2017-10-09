class Api::V1::PostsController < ApplicationController
	def index
		posts = Post.all.page(params[:page])
		posts = posts.each do |post|
			post.content = post.content[0..99]
			post
		end

		total_pages = Post.all.page.total_pages
		render json: { total_pages: total_pages, posts: posts }, status: 200 
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

	def destroy
		post = Post.find(params[:id])
		post.destroy
		head 204
	end

	private

	def post_params
		params.require(:post).permit(:title, :content)
	end
end