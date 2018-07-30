class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # if admin.is_main_administer == true
  	belongs_to :store,optional: true
  # else
  	# belongs_to :store
  # end
end
