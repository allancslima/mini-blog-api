angular.module("miniBlogApp").controller("postsController", function($scope, postsAPI) {
	$scope.posts = [];
	$scope.pages = [];
	var currentPage = 1;

	$scope.loadPosts = function(page) {
		currentPage = page;
		postsAPI.getPosts(page).then(function onSuccess(response) {
			$scope.posts = response.data.posts;
			for (var i=0; i < response.data.total_pages; i++)
				$scope.pages[i] = i+1;
		});
	};

	$scope.removePosts = function (posts) {
		$scope.posts.filter(function (post) {
			if (post.selected) {
				postsAPI.deletePost(post.id)
				.then(function onSuccess(response) {
					$scope.loadPosts(currentPage);
				});
			}
		});
	};

	$scope.isSelectedPost = function (posts) {
		return posts.some(function (post) {
			return post.selected;
		});
	};

	$scope.loadPosts();
});