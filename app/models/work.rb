class Work < ApplicationRecord
	belongs_to :staff
	has_many :breaks, dependent: :destroy
	accepts_nested_attributes_for :breaks,allow_destroy: true
end
