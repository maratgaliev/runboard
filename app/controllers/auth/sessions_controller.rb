class Auth::SessionsController < Devise::SessionsController
  
  skip_before_action :verify_signed_out_user, only: :destroy

  respond_to :json

  def create
    if user = warden.authenticate(auth_options)
      sign_in(resource_name, user)
      render json: { user: user }
    else
      error = I18n.t('errors.users.sign_in.base')
      render json: { error: { base: [error] } }, status: :unprocessable_entity
    end
  end

  def destroy
    if Devise.sign_out_all_scopes
      sign_out
    else
      sign_out(resource_name)
    end

    head :ok
  end
end
