angular.module('miniBlogApp').config(function($routeProvider) {
	$routeProvider
	.when("/posts", {
		templateUrl: "view/posts.html",
		controller: "postsController"
	});
});