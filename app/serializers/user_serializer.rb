class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :auth_token, :role

  def role
    object.roles.first[:name]
  end
end