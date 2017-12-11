module Mutations::TaskMutations
  Create = GraphQL::Relay::Mutation.define do
    name 'AddTask'

    input_field :task, !TaskInputObjectType

    return_field :task, Types::TaskType
    return_field :errors, types.String

    resolve lambda { |object, inputs, ctx|
      task = Task.new(inputs[:task].to_h)

      if task.save
        { task: task }
      else
        { errors: task.errors.to_a }
      end
    }
  end

  Update = GraphQL::Relay::Mutation.define do
    name 'UpdateTask'

    # Define input parameters
    input_field :id, !types.ID
    input_field :task, !TaskInputObjectType

    # Define return parameters
    return_field :task, Types::TaskType
    return_field :errors, types.String

    resolve lambda { |_object, inputs, _ctx|
      task = Task.find_by_id(inputs[:id])
      return { errors: 'Task not found' } if task.nil?

      if task.update_attributes(inputs[:task].to_h)
        { task: task }
      else
        { errors: task.errors.to_a }
      end
    }
  end

  Destroy = GraphQL::Relay::Mutation.define do
    name 'DestroyTask'
    description 'Delete a task and return  deleted task ID'

    # Define input parameters
    input_field :id, !types.ID

    # Define return parameters
    return_field :deletedId, !types.ID
    return_field :errors, types.String

    resolve lambda { |_obj, inputs, _ctx|
      task = Task.find_by_id(inputs[:id])
      return { errors: 'Task not found' } if task.nil?

      task.destroy
      { deletedId: inputs[:id] }
    }
  end
end