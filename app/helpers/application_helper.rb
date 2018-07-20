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
end
