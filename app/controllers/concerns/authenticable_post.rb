module AuthenticablePost
	def current_post
		@current_post ||= Post.find_by(id: params[:post_id])
	end

	def authenticate_post_with_id!
		render json: { errors: 'Post does not exist' }, status: 404 unless existing_post?
	end

	def existing_post?
		current_post.present?
	end
end