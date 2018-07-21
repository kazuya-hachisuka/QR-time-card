class Staff < ApplicationRecord
	belongs_to :store
	has_many :works

	def worked
		require "date"
		today = Date.today
		works.where(in: today.in_time_zone.all_day).exists?
	end

end
