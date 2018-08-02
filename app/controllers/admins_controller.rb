class AdminsController < ApplicationController
	before_action :authenticate_admin!
	def index
		@admin = Admin.all
		@staff = Staff.all
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
		if @admin.id != current_admin.id && current_admin.is_main_administer == false
      redirect_to admins_top_path
    else
			if @admin.update(admin_params)
				sign_in(current_admin, :bypass => true)
				redirect_to admins_path
				flash[:admin_updated] = "管理者 #{@admin.family_name}#{@admin.given_name}の登録情報を変更しました"
			else
				redirect_to edit_admin_path(current_admin.id)
	      flash[:admin_update_faled] = "変更できませんでした。入力内容を確認してください。"
	    end
	  end
  end

  def destroy
  	admin = Admin.find(params[:id])
  	admin.destroy
  	redirect_to admins_path
  end

  private

	def admin_params
    params.require(:admin).permit(:family_name,:given_name,:family_name_kana,:given_name_kana,:email,:password,:store_id)
  end

  def staff_params
  	params.require(:staff).permit(:id,:qrcode,:family_name,:family_name_kana,:given_name,:given_name_kana,:store_id,:work_id)
  end

  def store_params
    params.require(:store).permit(:store_name,:id)
  end
end
