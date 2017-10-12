# README

* **Ruby version**

	2.4.1

* **Rails version**

	5.1.4

* **Configuration**

	> cd mini-blog-api/
	> 
	> bundle install

	Set your mysql password in config/database.yml

Then:
> rake db:create
> 
> rake db:migrate
> 
> rails server

Access http://localhost:3000/

* **Tests suite**

	To run all tests: 

	> bundle exec spring rspec --format=d

	Post model

	> bundle exec spring rspec spec/models/post_spec.rb
	
	![enter image description here](https://i.imgur.com/cFHa50l.png)

	Comment model

	> bundle exec spring rspec spec/models/comment_spec.rb
	
	![enter image description here](https://i.imgur.com/KekFbR0.png)

	Posts controller

	> bundle exec spring rspec spec/requests/api/v1/posts_spec.rb
	
	![enter image description here](https://i.imgur.com/Fd3pnrt.png)

	Comments controller

	> bundle exec spring rspec spec/requests/api/v1/comments_spec.rb
	
	![enter image description here](https://i.imgur.com/pstiu4l.png)