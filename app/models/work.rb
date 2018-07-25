class Work < ApplicationRecord
	belongs_to :staff
	has_many :breaks,inverse_of: :work, dependent: :destroy
	accepts_nested_attributes_for :breaks,reject_if: :all_blank,allow_destroy: true

	validates :in, presence: true
end
