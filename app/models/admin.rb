class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	validates :family_name,      	presence: true
	validates :given_name,      	presence: true
	validates :family_name_kana,  presence: true
  validates :given_name_kana,  	presence: true

  belongs_to :store,optional: true
end
