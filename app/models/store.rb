class Store < ApplicationRecord

	validates :store_name, presence: true

	has_many :admins
	has_many :staffs
end
