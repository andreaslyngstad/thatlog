class User < ActiveRecord::Base
	has_attached_file :avatar, :styles => { :original => "100x100#", :small => "32x32#" }
                           
	validates_attachment_size :avatar, :less_than => 2.megabytes
	validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png']
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, 
  				:password, 
  				:password_confirmation, 
  				:remember_me, 
  				:name, 
  				:phone, 
  				:firm_id, 
  				:manager,
  				:role,
          :loginable_token,
  				:avatar,
  				:avatar_file_name, 
    			:avatar_content_type, 
    			:avatar_file_size,
    			:avatar_updated_at,
    			:hourly_rate
    			
 
  has_many :memberships
  has_many :projects, :through => :memberships
  has_many :logs
  has_many :todos
  belongs_to :firm
  validates_presence_of :name
  validates :email, :presence => true, :uniqueness => true, :email_format => true

  
 # def user_role
 #   errors.add(:role, "Not a legal role") if 
 #   !roles == "admin" or !roles == "member" or !roles == "user"
 # end
  def admin?
    false
  end

  def self.current_firm(firm)
    where("users.firm = ?", firm)
  end
  def self.valid_recover?(params)
    token_user = self.where(:loginable_token => params).first
    if token_user
      token_user.loginable_token = nil
      token_user.save
    end
    return token_user
  end
  def self.valid?(params)
    token_user = self.where(:loginable_token => params[:id]).first
    if token_user
      token_user.loginable_token = nil
      token_user.save
    end
    return token_user
  end

   def self.find_for_database_authentication(conditions)
   self.where(:email => conditions[:email]).first
  end
 
  
  def role?(role)
      return self.roles.nil? ? false : self.roles.include?(role.to_s)
  end
  
  

  
end
