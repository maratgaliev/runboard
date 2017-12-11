Types::MutationType = GraphQL::ObjectType.define do
  name 'Mutation'
  field :addTask, field: Mutations::TaskMutations::Create.field
  field :updateTask, field: Mutations::TaskMutations::Update.field
  field :destroyTask, field: Mutations::TaskMutations::Destroy.field
end


# Types::MutationType = GraphQL::ObjectType.define do
#   name "Mutation"
# end
