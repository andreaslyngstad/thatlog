class Firm < ActiveRecord::Base
	 attr_accessible :logo_file_name, :name,:subdomain,:address,:phone, :currency, :lang, :time_zone, :logo_file_name, 
	  	:logo,
	  	:logo_content_type,
	    :logo_file_size,
	    :logo_updated_at,
	   	:background,
	   	:color
  has_attached_file :logo, :styles => { :original => "100x100#" },
                  :url  => "/system/logos/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/system/logos/:id/:style/:basename.:extension"             
	validates_attachment_size :logo, :less_than => 2.megabytes
	validates_attachment_content_type :logo, :content_type => ['image/jpeg', 'image/png']
  has_many :customers 
  has_many :users
  has_many :todos
  has_many :logs
  has_many :projects
  validates_presence_of :name
 
  validates_format_of :subdomain, :with => /^[a-z0-9\_]+$/i
 
  validates :subdomain, :presence => true, :uniqueness => true,  :subdomain_exclutions => :true
  
  
  

end
 
