class Log < ActiveRecord::Base
  belongs_to :customer
  belongs_to :user
  belongs_to :firm
  belongs_to :project
  belongs_to :todo
  belongs_to :employee
  
 
  
  
  def end_string
    end_time.to_s(:db)
  end
  
  def end_string=(end_str)
    self.end_time = Time.parse(end_str)
  end
  
  def begin_string
    begin_time.to_s(:db)
  end
    
  def begin_string=(begin_str)
    self.begin_time = Time.parse(begin_str)
  end
  
end

