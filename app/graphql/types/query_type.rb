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

  field :tasks, !types[Types::TaskType] do
    argument :limit, types.Int, default_value: 10, prepare: -> (limit) { [limit, 30].min }
    resolve -> (obj, args, ctx) {
      Task.limit(args[:limit]).order(id: :desc)
    }
  end

  field :task do
    type Types::TaskType
    argument :id, !types.ID
    description "Find a Task by ID"
    resolve ->(obj, args, ctx) { Task.find_by_id(args["id"]) }
  end
end
