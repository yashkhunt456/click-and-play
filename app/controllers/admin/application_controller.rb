module Admin
    class ApplicationController < ActionController::Base
        before_action :authenticate_admin

        private

        def authenticate_admin
            redirect_to root_path, alert: "Not authorized" unless current_user&.has_role?(:admin)
        end
    end
end