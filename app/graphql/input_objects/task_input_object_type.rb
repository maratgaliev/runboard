TaskInputObjectType = GraphQL::InputObjectType.define do
  name 'TaskInput'
  input_field :title, !types.String
  input_field :description, !types.String
  input_field :user_id, types.Int
  input_field :due_date, types.String
end