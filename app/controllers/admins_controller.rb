class AdminsController < ApplicationController
	# before_action :authenticate_admin
 #  before_action :admin_exists, except: [:index]
 #  before_action :suspending_admin_account
	def index
		@admin = Admin.all
	end

	def edit
		@admin = Admin.find(params[:id])
		@store = Store.all
	end

	def show
		redirect_to admins_path
	end

	def update
		@admin = Admin.find(params[:id])
		@admin.update(admin_params)
		sign_in(current_admin, :bypass => true)
		redirect_to edit_admin_path(@admin.id)
		flash[:admin_updated] = "管理者 #{@admin.family_name}#{@admin.given_name}の登録情報を変更しました"
  end

  private

	def admin_params
    params.require(:admin).permit(:family_name, :given_name, :family_name_kana, :given_name_kana, :email, :password, :store_id)
  end
end
