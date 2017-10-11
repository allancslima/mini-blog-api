angular.module('miniBlogApp').config(function($routeProvider) {
	$routeProvider
	.when("/", {
		templateUrl: "view/posts.html",
		controller: "postsController"
	})

	.when("/newPost", {
		templateUrl: "view/newPost.html",
		controller: "newPostController"
	})
	
	.when("/post/:id", {
		templateUrl: "view/post.html",
		controller: "postController",
		resolve: {
			response: function(postsAPI, $route) {
				return postsAPI.getPost($route.current.params.id);
			}
		}
	});
});