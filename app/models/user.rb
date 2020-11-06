class User < ApplicationRecord
  	attr_accessor :username

    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  	enum user_type: { manager: 0, musician: 1, customer: 2 }

  	def email_required?
  		false
  	end
  
end
