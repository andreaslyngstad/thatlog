class User < ActiveRecord::Base
  acts_as_authentic
  has_many :memberships
  has_many :projects, :through => :memberships
  has_many :logs
  has_many :todos
  belongs_to :firm
  validates_presence_of :name
  
  def admin?
    false
  end
  
  def self.current_firm(firm)
    where("users.firms = ?", firm)
  end
  
end
