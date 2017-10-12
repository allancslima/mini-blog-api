require 'rails_helper'

RSpec.describe 'Posts API', type: :request do

	# using the 'post' name causes conflicts with the post method
	let(:publish) { create(:post) }
	let(:post_id) { publish.id }
	let(:headers) do
		{
			'Content-Type' => Mime[:json].to_s,
			'Accept' => 'application/vnd.miniblog.v1'
		}
	end

	before { host! 'localhost:3000/api' }


	describe 'GET /posts | for a total of 25 posts in the database' do
		let(:page) {}
		
		before do
			create_list(:post, 25)
			get '/posts', params: { page: page }, headers: headers
		end

		it 'returns status code 200' do
				expect(response).to have_http_status(200)
			end

		it 'returns the posts content with up to 100 characters' do
			expect( json_body[:posts].first[:content].length ).to be <= 100
		end

		context 'when the page is the first' do
			let(:page) { 1 }

			it 'returns 20 posts from database' do
				expect(json_body[:posts].count).to eq(20)
			end
		end

		context 'when the page is the second' do
			let(:page) { 2 }

			it 'returns 5 posts from database' do
				expect(json_body[:posts].count).to eq(5)
			end
		end	
	end


	describe 'GET /posts/:id' do
		before { get "/posts/#{post_id}", params: {}, headers: headers }

		context 'when the post exists' do
			it 'returns status code 200' do
				expect(response).to have_http_status(200)
			end

			it 'returns the json data for the post' do
				expect(json_body[:title]).to eq(publish.title)
			end
		end

		context 'when the post does not exist' do
			let(:post_id) { -1 }

			it 'returns status code 404' do
				expect(response).to have_http_status(404)
			end
		end
	end


	describe 'POST /posts' do
		before { post '/posts', params: { post: post_params }.to_json, headers: headers }

		context 'when the request params are valid' do
			let(:post_params) { attributes_for(:post) }

			it 'returns status code 201' do
				expect(response).to have_http_status(201)
			end

			it 'returns the json data for the created post' do
				expect(json_body[:title]).to eq(post_params[:title])
			end
		end

		context 'when the request params are invalid' do
			let(:post_params) { attributes_for(:post, title: '') }

			it 'returns status code 422' do
				expect(response).to have_http_status(422)
			end

			it 'returns the json error for title' do
				expect(json_body[:errors]).to have_key(:title)
			end
		end
	end


	describe 'PUT /posts/:id' do
		before { put "/posts/#{post_id}", params: { post: post_params }.to_json, headers: headers }

		context 'when the request params are valid' do
			let(:post_params) { { title: 'New post title' } }

			it 'returns status code 200' do
				expect(response).to have_http_status(200)
			end

			it 'returns the json data for the update user' do
				expect(json_body[:title]).to eq(post_params[:title])
			end
		end

		context 'when the request params are invalid' do
			let(:post_params) { { title: '' } }

			it 'returns status code 422' do
				expect(response).to have_http_status(422)
			end

			it 'returns the json error for title' do
				expect(json_body[:errors]).to have_key(:title)
			end
		end
	end


	describe 'DELETE /posts/:id' do
		before { delete "/posts/#{post_id}", params: {}, headers: headers }

		it 'returns status code 204' do
			expect(response).to have_http_status(204)
		end

		it 'removes the post from database' do
			expect( Post.find_by(id: post_id) ).to be_nil
		end
	end

end