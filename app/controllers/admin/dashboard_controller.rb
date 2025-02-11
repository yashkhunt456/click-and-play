module Admin
  class Admin::DashboardController < ApplicationController
    
    def index
      @users = User.all
      @boxhouses = Boxhouse.all
    end

    def destroy
      @user = User.find_by(id: params[:id])
      
      if @user
        @user.destroy
        redirect_to admin_dashboard_index_path, notice: "User destroyed successfully!"
      else
        redirect_to admin_dashboard_index_path, alert: "User not found."
      end
    end
  end
end

