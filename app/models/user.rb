class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
 
  has_many :memberships, :dependent => :destroy
  has_many :groups, :through => :memberships
  has_many :group_admins, :dependent => :destroy
  has_many :membership_requests, :dependent => :destroy
end
