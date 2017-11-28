class Users::MainQuery

  include Dry::Transaction
  
  PER_PAGE = 10

  step :users_scope
  step :paginate

  def self.index_query(params = {}, &block)
    new.call(params: params, &block)
  end

  def users_scope(params:)
    Right(users: User, params: params)
  end

  def paginate(users:, params:)
    Right(users.ordered.paginate(page: params[:page], per_page: PER_PAGE))
  end
  
end
