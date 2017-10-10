angular.module("miniBlogApp").controller("postsController", function($scope, postsAPI) {
	$scope.posts = [];
	$scope.totalPages = 0;

	var loadPosts = function() {
		postsAPI.getPosts().then(function onSuccess(response) {
			$scope.posts = response.data.posts;
			$scope.totalPages = response.data.total_pages;
		});
	}

	loadPosts();
});