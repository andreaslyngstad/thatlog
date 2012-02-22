class Milestone < ActiveRecord::Base
  belongs_to :project
  validates_presence_of :goal
  
  def passed
  	Time.now.in_time_zone > due
  end
  
  
end
