class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :validatable, :confirmable


  has_one :membership, :primary_key => :email,
                       :foreign_key => :email

  validate :only_one_superadmin
  # Kaminari DSL
  paginates_per 30


  def active_for_authentication?
    super && self.enabled
 
  end

  def member?
    self.membership.active if self.membership
  end

  def self.set_superadmin old_user, new_user
    
    
    if old_user.superadmin?&&new_user.admin?
      User.transaction do
        
        old_user.update_attributes! superadmin: false
        new_user.update_attributes! superadmin: true        
        raise ActiveRecord::Rollback if User.where(superadmin:true).count != 1 
      end

    end

  end

  private

  def only_one_superadmin

    if self.superadmin_was==false&&self.superadmin==true      
      errors.add :superadmin, :only_one_superadmin_allowed if (User.where(superadmin:true).count!=0)
    end

  end

end
