angular.module("miniBlogApp").factory("postsAPI", function($http) {
	var _getPosts = function() {
		return $http.get("http://api.miniblog.dev:3000/posts");
	}

	return {
		getPosts: _getPosts
	};
});