angular.module("miniBlogApp").factory("postsAPI", function($http) {
	var _getPosts = function(page) {
		return $http.get("http://api.miniblog.dev:3000/posts", {
			params: { page: page }
		});
	}

	return {
		getPosts: _getPosts
	};
});