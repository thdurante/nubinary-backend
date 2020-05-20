module Api
  module V1
    class StringCalculationsController < BaseController
      def index
        render json: { data: current_user.string_calculations.order(created_at: :desc) }
      end

      def create
        string_calculation = ::StringCalculation.new(permitted_params.merge(user: current_user))

        if string_calculation.save
          render json: string_calculation, status: :created
        else
          render json: { errors: string_calculation.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        string_calculation = current_user.string_calculations.find_by(id: params[:id])
        string_calculation&.destroy

        head :no_content
      end

      private

      def permitted_params
        params.require(:string_calculation).permit(:source_str, :comparing_str)
      end
    end
  end
end
