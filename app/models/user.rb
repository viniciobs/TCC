class User < ApplicationRecord
  	attr_accessor :username

    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable  	

  	enum user_type: { manager: 0, musician: 1, customer: 2, kitchen: 3 }

  	scope :filter_by_type, -> (type) { where user_type: type }    
	  scope :filter_by_name, -> (name) { where("upper(name) like upper(?) OR upper(access) like (?)", "%#{name}%", "%#{name}%") }
    scope :filter_by_scheduled_today, -> { where scheduled_today: true }
    scope :filter_status, -> (status) { where active: status.to_i }

    has_one :order, dependent: :destroy
    has_many :songs, dependent: :destroy
    has_many :rates, dependent: :destroy
    has_many :artist_suggestions, dependent: :destroy

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
      elsif self.user_type == "kitchen"
        return "Cozinha"
      else 
        return "Cliente"
      end                
    end

    def type_value
      if self.user_type == "manager"
        return 0
      elsif self.user_type == "musician"
        return 1
      elsif self.user_type == "kitchen"
        return 3
      else 
        return 2
      end                
    end

    def scheduled_description
      return self.scheduled_today ? "S" : "N"
    end  

    def active_description
      return self.active ? "S" : "N"
    end
end
