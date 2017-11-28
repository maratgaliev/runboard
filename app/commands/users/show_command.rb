class Users::ShowCommand < BaseCommand
  
  step :get

  def get(id:)
    user = User.find_by(id: id)
    user ? Right(user) : Left(error(I18n.t('errors.users.not_found')))
  end

end
