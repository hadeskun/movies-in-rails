class User < ActiveRecord::Base
  authenticates_with_sorcery!

  # attr_accessible :title, :body
  attr_accessible :password, :password_confirmation, :email, :crypted_password, :salt

  #Un usuario posee muchos posts
  has_many :posts

  validates :email, uniqueness: true

  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  #Variables virtuales 'password' y 'password_confirmation'
  #Debido a eso se utlizan getters and setters

  def password
    @crypted_password
   
  end
 
  def password_confirmation
    @salt
       
  end
 
  def password=(val)
    @crypted_password = val
  end
 
  def password_confirmation=(val)
    @salt = val
  end
	
  
end
