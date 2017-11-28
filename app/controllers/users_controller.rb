class UsersController < ApplicationController

  before_action :authenticate_user!, except: [:index]

  rescue_from ActiveRecord::RecordNotFound do
    head :not_found
  end

  def index
    Users::MainQuery.index_query(params) do |q|
      q.success { |users| api_response(users) }
      q.failure { api_response([]) }
    end
  end

  private

  def api_response(data)
    render json: data
  end

  def error_response(errors)
    render json: {errors: errors}, status: :unprocessable_entity
  end
end
