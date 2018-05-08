class User < ApplicationRecord

	def authenticate(password)
		return (password == self.password)
	end
end
