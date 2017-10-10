angular.module("miniBlogApp").controller("newPostController", function($scope, postsAPI, $location) {
	$scope.addPost = function(post) {
		postsAPI.savePost(post)
		.then(function onSuccess(response) {
			delete $scope.post;
			$location.path("/posts")
		});
	}
});