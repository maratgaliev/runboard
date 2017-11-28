Users::SignUpForm = Dry::Validation.Form do
  configure do

    def email?(value)
      !Devise.email_regexp.match(value).nil?
    end

    def phone?(value)
      !User.exists?(phone: value)
    end

    def login?(value)
      !User.exists?(login: value)
    end

    def password?(value)
      value.length.in?(Devise.password_length)
    end
  end

  required(:email).filled(:str?, :email?)
  required(:name).filled(:str?)
  required(:bio).filled(:str?)
  required(:login).filled(:str?, { min_size?: 3 }, :login?)
  required(:phone).filled(:str?, :phone?)
  required(:password).filled(:str?, :password?)
end
