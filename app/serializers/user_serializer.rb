class UserSerializer < ActiveModel::Serializer
  attributes :id, :login, :email, :bio, :name, :phone, :position

  has_many :projects
end