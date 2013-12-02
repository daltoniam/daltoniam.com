class IndexPostSerializer < ActiveModel::Serializer
	embed :ids
  attributes :id, :title, :preview, :created_at
  has_many :comments
end