module Users
  class RegistrationsController < Devise::RegistrationsController
    respond_to :json
  end
end
