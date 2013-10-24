class SecretController < ApplicationsController
	http_basic_authenticate_with :name => "houston", password: "golden1234"
	def show
end