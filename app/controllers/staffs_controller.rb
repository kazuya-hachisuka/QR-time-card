class StaffsController < ApplicationController
	  def new
  	@staff = Staff.new
    @store = Store.all
  end

  def create
  	@staff = Staff.new(staff_params)
  	@staff.save
  	puts @staff.id
  	redirect_to staff_path(@staff.id)
  end

  def index
    @staff = Staff.find(params[:id])
  end

  def update
    staff = Staff.find(params[:id])
    staff.update(staff_params)
    redirect_to staff_path
  end

  def show
  	@staff = Staff.find(params[:id])
    @store = Store.all
  	require 'chunky_png/rmagick' # Magick::Image、ChunkyPNG::Image 間の変換に使用

    text = "http://localhost:3000/staffs/#{@staff.id.to_s}/works/new"
    width = 200
    height = 200

    qr = RQRCode::QRCode.new(text, :size => 10, :level => :h)
    # ChunkyPNG::Image を Magick::Image に変換
    image = ChunkyPNG::RMagick.export(qr.to_img.resize(width, height))

    # draw = Magick::Draw.new
    # draw.annotate(image, 0, 0, width / 2, height - 2, "id:#{staff.id}") do
    #   self.fill = '#000000'
    #   self.align = Magick::LeftAlign
    #   self.stroke = 'transparent'
    #   self.pointsize = 8
    #   self.text_antialias = true
    #   self.kerning = 1
    # end

    # Magick::Image を ChunkyPNG::Image に変換して、DetaUrl に
    @qrpng = ChunkyPNG::RMagick.import(image).to_data_url
    @staff.qrcode = @qrpng
    @staff.save
    #ransack
    @search = @staff.works.ransack(params[:q])
    @works = @search.result
    @breaks = 0
    @works.order(:in).each do |workday|
      workday.breaks.each do |break_time|
          unless break_time.break_out.blank?
            off_time = (break_time.break_out.in_time_zone - break_time.break_in.in_time_zone)
            @breaks += off_time
          end
      end
    end
  end

  def destroy
    staff = Staff.find(params[:id])
    staff.destroy
    redirect_to stores_path
  end

  private
  def staff_params
  	params.require(:staff).permit(:id,:qrcode,:family_name,:family_name_kana,:given_name,:given_name_kana,:store_id,:work_id)
  end

  def params_work
    params.require(:work).permit(:in,:out,:staff_id,:break_id)
  end

  def params_break
    params.require(:break).permit(:id,:break_in,:break_out,:work_id)
  end

  def store_params
    params.require(:store).permit(:store_name,:id)
  end
end
