Types::UserType = GraphQL::ObjectType.define do
  name 'User'

  field :id, !types.ID
  field :login, !types.String
  field :bio, types.String
  field :avatar, types.String
  field :phone, types.String
  field :position, types.String
  field :name, types.String
  field :email, types.String

  field :projects, !types[Types::ProjectType] do
    argument :limit, types.Int, default_value: 10, prepare: -> (limit) { [limit, 30].min }
    resolve -> (obj, args, ctx) {
      obj.projects.limit(args[:limit])
    }
  end

  field :updated_at do
    type types.Int

    resolve -> (obj, args, ctx) {
      obj.updated_at.to_i
    }
  end

  field :created_at do
    type types.Int

    resolve -> (obj, args, ctx) {
      obj.created_at.to_i
    }
  end
end