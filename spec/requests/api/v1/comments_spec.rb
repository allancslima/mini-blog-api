require 'rails_helper'

RSpec.describe 'Comments API', type: :request do

	# using the 'post' name causes conflicts with the post method
	let!(:publish) { create(:post) }
	let(:post_id) { publish.id }
	let(:headers) do
		{
			'Content-Type' => Mime[:json].to_s,
			'Accept' => 'application/vnd.miniblog.v1'
		}
	end

	before { host! 'api.miniblog.dev' }


	describe 'GET /posts/:post_id/comments' do
		before do
			create_list(:comment, 5, post_id: post_id)
			get "/posts/#{post_id}/comments", params: {}, headers: headers
		end

		it 'returns status code 200' do
			expect(response).to have_http_status(200)
		end

		it 'returns 5 comments from database' do
			expect(json_body[:comments].count).to eq(5)
		end
	end


	describe 'GET /posts/:post_id/comments/:comment_id' do
		let!(:comment) { create(:comment, post_id: post_id) }
		let(:comment_id) { comment.id }

		before { get "/posts/#{post_id}/comments/#{comment_id}", params: {}, headers: headers }

		context 'when the comment exists' do
			it 'returns status code 200' do
				expect(response).to have_http_status(200)
			end

			it 'returns the json data for the comment' do
				expect(json_body[:body]).to eq(comment.body)
			end
		end

		context 'when the comment does not exist' do
			let(:comment_id) { -1 }

			it 'returns status code 404' do
				expect(response).to have_http_status(404)
			end
		end
	end


	describe 'POST /posts/:post_id/comments' do
		before { post "/posts/#{post_id}/comments", params: { comment: comment_params }.to_json, headers: headers }

		context 'when the request params are valid' do
			let(:comment_params) { attributes_for(:comment) }

			it 'returns status code 201' do
				expect(response).to have_http_status(201)
			end

			it 'returns the json data for the created comment' do
				expect(json_body[:email]).to eq(comment_params[:email])
			end

			it 'saves comment in the database' do
				expect( Comment.find_by(body: comment_params[:body]) ).not_to be_nil
			end

			it 'assigns the created comment to the current post' do
				expect(json_body[:post_id]).to eq(post_id)
			end
		end

		context 'when the request params are invalid' do
			let(:comment_params) { attributes_for(:comment, email: 'invalid_email@') }

			it 'returns status code 422' do
				expect(response).to have_http_status(422)
			end

			it 'does not save the comment in the database' do
				expect( Comment.find_by(body: comment_params[:body]) ).to be_nil
			end

			it 'returns the json error for email' do
				expect(json_body[:errors]).to have_key(:email)
			end
		end
	end


	describe 'PUT /posts/:post_id/comments/:commment_id' do
		let!(:comment) { create(:comment, post_id: post_id) }
		
		before { put "/posts/#{post_id}/comments/#{comment.id}", params: { comment: comment_params }.to_json, headers: headers }

		context 'when the params are valid' do
			let(:comment_params) { { body: 'New comment body' } }

			it 'returns status code 200' do
				expect(response).to have_http_status(200)
			end

			it 'returns the json data for the updated comment' do
				expect(json_body[:body]).to eq(comment_params[:body])
			end

			it 'updates the comment in the database' do
				expect( Comment.find_by(body: comment_params[:body]) ).not_to be_nil
			end
		end

		context 'when the params are invalid' do
			let(:comment_params) { { body: '' } }

			it 'returns status code 422' do
				expect(response).to have_http_status(422)
			end

			it 'returns the json error for body' do
				expect(json_body[:errors]).to have_key(:body)
			end

			it 'does not update the comment in the database' do
				expect( Comment.find_by(body: comment_params[:body]) ).to be_nil
			end
		end
	end


	describe 'DELETE /posts/:post_id/comments/:commment_id' do
		let!(:comment) { create(:comment, post_id: post_id) }

		before { delete "/posts/#{post_id}/comments/#{comment.id}", params: {}, headers: headers }

		it 'returns status code 204' do
			expect(response).to have_http_status(204)
		end

		it 'removes the comment from database' do
			expect( Comment.find_by(id: comment.id) ).to be_nil
		end
	end

end