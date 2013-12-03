class Post < ActiveRecord::Base
	default_scope {order("created_at DESC") }
	has_many :comments
end
