module Admin
  class Admin::DashboardController < ApplicationController
    
    def index
      @users = User.all
      @boxhouses = Boxhouse.all
    end

    def destroy
      @user = User.find_by(id: params[:id])
      @boxhouse = Boxhouse.find_by(id: params[:id])
      
      if @user
        @user.destroy
        redirect_to admin_dashboard_index_path, notice: "User destroyed successfully!"
      else
        redirect_to admin_dashboard_index_path, alert: "User not found."
      end

      if @boxhouse
        @boxhouse.destroy
        redirect_to admin_dashboard_index_path, notice: "Boxhouse destroyed successfully!"
      else
        redirect_to admin_dashboard_index_path, alert: "Boxhouse not found."
      end
    end
  end
end

