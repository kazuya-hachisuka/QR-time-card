class StoresController < ApplicationController
	before_action :authenticate_admin!

	def index
		@store = Store.all
	end

	def new
		@store = Store.new
	end

	def create
		@store = Store.new(params_store)
		if @store.save
			redirect_to stores_path
			flash[:store_created] = "#{@store.store_name}店を追加しました。"
		else
			redirect_to new_store_path
			flash[:store_create_faled] = "追加出来ませんでした。再度、入力して下さい。"
		end
	end

	def show
		@store = Store.find(params[:id])
		@staff = @store.staffs
		@breaks = 0
		@outyet = 0
		@store_total_times = 0
		@store.staffs.each do |staff|
	    staff.works.each do |workday|
	    	unless workday.out.present?
	    		@outyet += 1
	    	end
	    end
	  end
	  #ransack
	  @search = Work.ransack(params[:q])
    @works = Work.ransack(params[:q]).result
    @sum = 0
    @offtime = 0
    total = 0

    @works.each do |work|
		    if @store.staffs.pluck(:id).include?(work.staff_id) && work.out != nil
		    	@sum += work.out.in_time_zone - work.in.in_time_zone
		    work.breaks.each do |breaktime|
		    	unless breaktime.break_out.blank?
		    		@offtime += breaktime.break_out.in_time_zone - breaktime.break_in.in_time_zone
		    	end
		    end
	    end
	  end
	end

	def update
		@store = Store.find(params[:id])
		if @store.update(params_store)
			redirect_to  store_path
			flash[:store_updated] = "店舗情報を更新しました。"
		else
			redirect_to  store_path
			flash[:store_update_faled] = "店舗情報を更新出来ませんでした。"
		end
	end

	def destroy
		store = Store.find(params[:id])
		store.destroy
		redirect_to stores_path
	end

	private

	def params_store
		params.require(:store).permit(:store_name,:admin_id,:staff_id)
	end

	def staff_params
  	params.require(:staff).permit(:id,:qrcode,:family_name,:family_name_kana,:given_name,:given_name_kana,:store_id)
  end

  def params_work
    params.require(:work).permit(:id,:in,:out,:staff_id,:break_id)
  end

end
