angular.module("miniBlogApp").factory("postsAPI", function($http) {
	var apiBase = "http://api.miniblog.dev:3000";

	var _getPosts = function(page) {
		return $http.get(apiBase + "/posts", {
			params: { page: page }
		});
	}
	var _getPost = function(postId) {
		return $http.get(apiBase + "/posts/" + postId);
	}
	var _getPostComments = function(postId) {
		return $http.get(apiBase + "/posts/" + postId + "/comments");
	}
	var _savePost = function(post) {
		return $http.post(apiBase + "/posts", {
			post: post
		});
	}
	var _saveComment = function(comment, postId) {
		return $http.post(apiBase + "/posts/" + postId + "/comments", {
			comment: comment
		});
	}

	return {
		getPosts: _getPosts,
		getPost: _getPost,
		getPostComments: _getPostComments,
		savePost: _savePost,
		saveComment: _saveComment
	};
});