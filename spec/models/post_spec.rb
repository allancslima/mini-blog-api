require 'rails_helper'

RSpec.describe Post, type: :model do
	let(:post) { build(:post) }

	it { is_expected.to have_many(:comments).dependent(:destroy) }

	it { is_expected.to validate_presence_of(:title) }

	it { is_expected.to respond_to(:title) }
	it { is_expected.to respond_to(:content) }
end