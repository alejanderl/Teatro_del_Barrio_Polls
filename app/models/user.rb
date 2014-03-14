class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :confirmable


  has_one :membership, :primary_key => :email,
                       :foreign_key => :email



  def active_for_authentication?
    super && self.enabled
 
  end
end
