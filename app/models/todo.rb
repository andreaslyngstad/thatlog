class Todo < ActiveRecord::Base
  belongs_to :customer
  belongs_to :project
  belongs_to :user
  belongs_to :firm
  has_many :logs
  
  validates_presence_of :name
  
  
  
end
