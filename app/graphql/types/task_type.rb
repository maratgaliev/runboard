Types::TaskType = GraphQL::ObjectType.define do
  name 'Task'

  field :id, !types.ID
  field :title, !types.String
  field :description, !types.String
  field :due_date, types.String

  field :user, !types[Types::UserType] do
    resolve -> (obj, args, ctx) {
      RecordLoader.for(User).load(obj.user_id)
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