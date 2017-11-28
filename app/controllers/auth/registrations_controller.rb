class Auth::RegistrationsController < Devise::RegistrationsController
  
  respond_to :json

  def create
    Users::SignUpCommand.run(user_params) do |c|
      c.success do |user|
        sign_up(resource_name, user)
        render json: { user: user }
      end

      c.failure do |errors|
        render json: { errors: errors }, status: :unprocessable_entity
      end
    end
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  private

  def user_params
    params.require(:user).permit([:email, :login, :password, :avatar, :position, :bio, :phone, :name])
  end
end
