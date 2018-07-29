class AdminsController < ApplicationController
	def index
		@admin = Admin.all
	end

	def edit
		@admin = Admin.find(params[:admin_id])
		@store = Store.all
	end
	def admin_params
    params.require(:admin).permit(:family_name_kanji, :given_name_kanji, :family_name_kana, :given_name_kana, :email, :password, :is_deleted)
  end
end
