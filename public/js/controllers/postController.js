angular.module("miniBlogApp").controller("postController", function($scope, response, postsAPI) {
	$scope.post = response.data;

	var loadComments = function() {
		postsAPI.getPostComments($scope.post.id)
		.then(function onSuccess(response) {
			$scope.post.comments = response.data.comments;
		});
	}
	
	loadComments();
});