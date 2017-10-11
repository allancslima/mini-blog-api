FactoryGirl.define do
	factory :comment do
		name { Faker::Name.name }
		email { Faker::Internet.email }
		body { Faker::Lorem.paragraph }
		post
	end
end