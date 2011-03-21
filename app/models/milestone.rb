class Milestone < ActiveRecord::Base
  belongs_to :project
  validates_presence_of :goal
  
  def passed
  	Time.now > due
  end
 
end
