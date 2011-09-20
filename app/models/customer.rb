class Customer < ActiveRecord::Base
  belongs_to :firm
  has_many :logs
  has_many :recent_logs, :class_name => "Log", :order => "log_date DESC", :conditions => ['log_date > ?', Time.now.beginning_of_week]
  has_many :projects
  has_many :employees, :dependent => :destroy
  validates_presence_of :name
  
  
end
