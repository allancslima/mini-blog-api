angular.module("miniBlogApp").factory("postsAPI", function($http) {
	var _getPosts = function(page) {
		return $http.get("http://api.miniblog.dev:3000/posts", {
			params: { page: page }
		});
	}
	var _getPost = function(postId) {
		return $http.get("http://api.miniblog.dev:3000/posts/" + postId);
	}
	var _getPostComments = function(postId) {
		return $http.get("http://api.miniblog.dev:3000/posts/" + postId + "/comments");
	}
	var _savePost = function(post) {
		return $http.post("http://api.miniblog.dev:3000/posts", {
			post: post
		});
	}

	return {
		getPosts: _getPosts,
		getPost: _getPost,
		getPostComments: _getPostComments,
		savePost: _savePost
	};
});