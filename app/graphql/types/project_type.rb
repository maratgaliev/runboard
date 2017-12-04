Types::ProjectType = GraphQL::ObjectType.define do
  name 'Project'

  field :id, !types.ID
  field :title, !types.String
  field :description, !types.String
  field :logo, !types.String
end