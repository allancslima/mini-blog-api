class ApiVersionConstraint

	def initialize(options)
		@version = options[:version]
		@default = options[:default]
	end

	def matches?(req)
		# goes through the constraints if @default marked with true
		@default || req.headers['Accept'].include?("application/vnd.miniblog.v#{@version}")
	end

end