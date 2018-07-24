module ApplicationHelper
# def qrcode_tag(text, options = {})
#    ::RQRCode::QRCode.new(text = Staff.where(id:1).pluck(:name).to_s).as_svg(options).html_safe
# end
	def h_mm(sec)
		min = sec.to_i / 60
		hh , mm = min.divmod(60)
		"%dh%02dm" % [hh,mm]
	end

  def qrcode_tag(text, options = {})
    ::RQRCode::QRCode.new("https://github.com/whomwah/rqrcode/blob/master/README.md").as_svg(options).html_safe
  end

  def totalwork(works)
		totalwork = 0
    works.each do |workday|
    	if workday.out.present?
	    sec = (workday.out.in_time_zone - workday.in.in_time_zone)
	    totalwork += sec
    	end
    end
    return totalwork
	end

	# def totalbreak(breaks)
	# 	totalbreak = 0
	# 	breaks.each do |break_time|
	# 		unless break_time.break_out.blank?
	# 			off_time = (break_time.break_out.in_time_zone - break_time.break_in.in_time_zone)
	# 			totalbreak += off_time
	# 			end
	# 		end
	# 		return totalbreak
	# end

end
