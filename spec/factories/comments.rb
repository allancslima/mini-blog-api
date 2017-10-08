FactoryGirl.define do
	factory :comment do
		name { Faker::Name.name }
		email { Faker::Internet.email }
		content { Faker::Lorem.paragraph }
		post
	end
end