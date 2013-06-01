class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username,
   :admin, :firstname, :lastname
  # attr_accessible :title, :body

  validates :username, :presence => true, :uniqueness => true, :format => { :with => /^[\w-]+$/ }, :length => { :minimum => 4, :maximum => 20 }
  validates :firstname, :presence => true, :format => { :with => /^[a-zA-Z]+$/ }, :length => { :minimum => 2, :maximum => 20 }
  validates :lastname, :presence => true, :format => { :with => /^[a-zA-Z]+$/ }, :length => { :minimum => 2, :maximum => 20 }

  def email_required?
    false
  end
end
