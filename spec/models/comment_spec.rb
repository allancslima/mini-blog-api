require 'rails_helper'

RSpec.describe Comment, type: :model do
	let(:comment) { build(:comment) }

	it { is_expected.to belong_to(:post) }

	it { is_expected.to validate_presence_of(:name) }
	it { is_expected.to validate_presence_of(:email) }
	it { is_expected.to validate_presence_of(:body) }
	it { is_expected.to validate_presence_of(:post_id) }
	it { is_expected.to allow_value('allancslima@gmail.com').for(:email) }

	it { is_expected.to respond_to(:name) }
	it { is_expected.to respond_to(:email) }
	it { is_expected.to respond_to(:body) }
	it { is_expected.to respond_to(:post_id) }
end