module Users
  class SessionsController < Devise::SessionsController
    respond_to :json

    skip_before_action :verify_signed_out_user, only: :destroy

    private

    def respond_to_on_destroy
      head :no_content
    end
  end
end
