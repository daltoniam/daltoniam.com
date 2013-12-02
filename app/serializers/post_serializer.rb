class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :text, :created_at
  has_many :comments
end