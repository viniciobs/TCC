class User < ApplicationRecord
  	attr_accessor :username

    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable  	

  	enum user_type: { manager: 0, musician: 1, customer: 2 }

  	scope :filter_by_type, -> (type) { where user_type: type }
	  scope :filter_by_name, -> (name) { where("upper(name) like upper(?) OR upper(username) like (?)", "%#{name}%", "%#{name}%") }

  	def email_required?
  		false
  	end

    def will_save_change_to_email?
      false
    end

    def type_description
      if self.user_type == "manager"
        return "Admin"
      elsif self.user_type == "musician"
        return "Artista"
      else 
        return "Cliente"
      end                
    end
  
end
