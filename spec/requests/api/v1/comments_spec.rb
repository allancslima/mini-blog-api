require 'rails_helper'

RSpec.describe 'Comments API' do
	before { host! 'api.miniblog.dev' }

	let!(:post) { create(:post) }
	let(:headers) do
		{
			'Content-Type' => Mime[:json].to_s,
			'Accept' => 'application/vnd.miniblog.v1'
		}
	end


	describe 'GET /posts/:post_id/comments' do
		before do
			create_list(:comment, 5, post_id: post.id)
			get "/posts/#{post.id}/comments", params: { post_id: post.id }, headers: headers
		end

		it 'returns status code 200' do
			expect(response).to have_http_status(200)
		end

		it 'returns 5 comments from database' do
			expect(json_body[:comments].count).to eq(5)
		end
	end


	describe 'GET /posts/:post_id/comments/:comment_id' do
		let(:comment) { create(:comment, post_id: post.id) }
		let(:comment_id) { comment.id }
		before do
			get "/posts/#{post.id}/comments/#{comment.id}", params: { post_id: post.id, comment_id: comment_id }, headers: headers
		end

		context 'when the comment exists' do
			it 'returns status code 200' do
				expect(response).to have_http_status(200)
			end

			it 'returns the json data for the comment' do
				expect(json_body[:email]).to eq(comment.email)
			end
		end

		context 'when the comment does not exist' do
			let(:comment_id) { -1 }

			it 'returns status code 404' do
				expect(response).to have_http_status(404)
			end
		end
	end

end