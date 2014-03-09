class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :confirmable
  has_many :memberships
  has_many :roles, :through => :memberships


  def active_for_authentication?
    super && self.enabled
 
  end
end
