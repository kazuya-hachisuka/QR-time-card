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

	private
	def params_store
		params.require(:store).permit(:store_name,:admin_id,:staff_id)
	end

	def staff_params
  	params.require(:staff).permit(:id,:qrcode,:family_name,:family_name_kana,:given_name,:given_name_kana,:store_id)
  end
end
