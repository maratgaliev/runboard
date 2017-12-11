Types::ProjectType = GraphQL::ObjectType.define do
  name 'Project'

  field :id, !types.ID
  field :title, !types.String
  field :description, !types.String
  field :logo, !types.String

  field :users, !types[Types::UserType] do
    argument :limit, types.Int, default_value: 10, prepare: -> (limit) { [limit, 30].min }
    resolve -> (obj, args, ctx) {
      obj.users.limit(args[:limit])
    }
  end
end