class StoresController < ApplicationController
	def index
		@store = Store.all
	end

	def new
		@store = Store.new
	end

	def create
		@store = Store.new(params_store)
		@store.save
		redirect_to stores_path
	end

	def show
		@store = Store.find(params[:id])
	end

	def update
		@store = Store.find(params[:id])
		@store.update(params_store)
		redirect_to  stores_path
	end

	def destroy
		store = Store.find(params[:id])
		store.destroy
		redirect_to stores_path
	end

	def store_total_work
		@store = Store.find(params[:store_id])
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
