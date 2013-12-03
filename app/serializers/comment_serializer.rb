class CommentSerializer < ActiveModel::Serializer
  attributes :id, :user, :text, :created_at
end