class Customer < ActiveRecord::Base
  belongs_to :firm
  has_many :logs
  has_many :projects
  has_many :employees, :dependent => :destroy
  validates_presence_of :name
  
end
