class UsersController < ApplicationController

  before_action :authenticate_user!, except: [:index]

  def index
    Users::MainQuery.index_query(params) do |q|
      q.success { |users| api_response(users) }
      q.failure { api_response([]) }
    end
  end

  def show
    run_command(Users::ShowCommand, id: params[:id])
  end

  private

  def api_response(data)
    render json: data
  end

  def error_response(errors)
    render json: { errors: errors }, status: :unprocessable_entity
  end

  def run_command(command, params)
    command.run(params) do |m|
      m.success { |user| api_response(user) }
      m.failure { |errors| error_response(errors) }
    end
  end

end
