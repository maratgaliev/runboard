Types::QueryType = GraphQL::ObjectType.define do
  name "Query"
  field :users, !types[Types::UserType] do
    argument :limit, types.Int, default_value: 10, prepare: -> (limit) { [limit, 30].min }
    resolve -> (obj, args, ctx) {
      User.limit(args[:limit]).order(id: :desc)
    }
  end

  field :projects, !types[Types::ProjectType] do
    argument :limit, types.Int, default_value: 10, prepare: -> (limit) { [limit, 30].min }
    resolve -> (obj, args, ctx) {
      Project.limit(args[:limit]).order(id: :desc)
    }
  end
end
