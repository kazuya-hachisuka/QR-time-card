class Staff < ApplicationRecord

	validates :family_name,      	presence: true
	validates :given_name,      	presence: true
	validates :family_name_kana,  presence: true
  validates :given_name_kana,  	presence: true

	belongs_to :store
	has_many :works

	def worked
		require "date"
		today = Date.today
		works.where(in: today.in_time_zone.all_day).exists?
	end

end
