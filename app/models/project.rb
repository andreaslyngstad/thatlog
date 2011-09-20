class Project < ActiveRecord::Base
  belongs_to :firm
  has_many :todos
  has_many :logs
  has_many :recent_logs, :class_name => "Log", :order => "log_date DESC", :conditions => ['log_date > ?', Time.now.beginning_of_week]
  has_many :milestones
  belongs_to :customer
  validates_presence_of :name
  has_many :memberships
  has_many :users, :through => :memberships
  
	

	

end

 