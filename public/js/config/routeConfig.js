angular.module('miniBlogApp').config(function($routeProvider) {
	$routeProvider
	.when("/posts", {
		templateUrl: "view/posts.html",
		controller: "postsController"
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