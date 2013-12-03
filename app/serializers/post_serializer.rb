class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :text, :preview, :created_at
  has_many :comments
end