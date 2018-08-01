class WorksController < ApplicationController
	before_action :authenticate_admin!,:except=>[:new, :update, :create, :shift_out, :break_create, :break_update]

	def index
		@staff = Staff.find(params[:staff_id])
	end

	def show
		@staff = Staff.find(params[:staff_id])
	end

	def new
		@staff = Staff.find(params[:staff_id])
	end

	def update
		require "date"
		@work = Work.find(params[:id])
		@work.update(params_work)
		redirect_to staff_path(params[:staff_id])
	end

	def create
		require "date"
		@work = Work.new
		@work.in = DateTime.now
		@staff = Staff.find(params[:staff_id])
		@staff.status = 1
		@staff.save
		@work.staff_id = @staff.id
		@work.save
		redirect_to root_path
	end

	def shift_out
		require "date"
		@staff = Staff.find(params[:staff_id])
		@staff.status = 0
		@staff.save
		work = Work.find(params[:work_id])
		work.update(out: DateTime.now)
		redirect_to root_path
	end

	def break_create
		require "date"
		@staff = Staff.find(params[:staff_id])
		@staff.status = 2
		@staff.save
		@work = Work.find(params[:work_id])
		@break = @work.breaks.build(break_in: DateTime.now )
		@break.save
		redirect_to root_path
	end

	def break_update
		require "date"
		@staff = Staff.find(params[:staff_id])
		@staff.status = 1
		@staff.save
		@break = Break.last
		@break.update(break_out: DateTime.now)
		redirect_to root_path
	end

	def edit
		# require "date"
		@staff = Staff.find(params[:staff_id])
		@work = Work.find(params[:id])
	end

	def destroy
		work = Work.find(params[:id])
		work.destroy
		redirect_to staff_path(params[:staff_id])
	end

	def break_destroy
	 	@breaks = Break.find_by(params[:work_id])
	 	@breaks.destroy
	 	redirect_to staff_path(params[:staff_id])
	end

	def add_work
		@staff = Staff.find(params[:staff_id])
		store = Store.all
		@work = Work.new
		@break = @work.breaks.build
	end

	def add_work_create
		@staff = Staff.find(params[:staff_id])
		@work = Work.new(params_work)
		@work.staff_id = @staff.id
		if @work.save
			redirect_to staff_path(params[:staff_id])
		else
			flash[:add_work_faled] = "入力項目を確認して下さい。"
			render :add_work
		end
	end

	private

	def params_staff
		params.require(:staff).permit(:name,:work_id,:qrcode,:id,:status)
	end

	def params_work
		params.require(:work).permit(:in,:out,:staff_id,:break_id,
			breaks_attributes:[:break_in,:break_out,:work_id,:id,:_destroy])
	end

	def params_break
		params.require(:break).permit(:id,:break_in,:break_out,:work_id)
	end

	def params_store
		params.require(:store).permit(:store_name)
	end
end
