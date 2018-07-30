class Store < ApplicationRecord
	has_many :admins
	has_many :staffs
end
