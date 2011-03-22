class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :phone, :firm_id, :manager
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
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
