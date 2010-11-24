class Group < ActiveRecord::Base
  has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships
  has_many :group_admins, :dependent => :destroy
  has_many :membership_requests, :dependent => :destroy
end
