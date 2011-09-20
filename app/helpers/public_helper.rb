module PublicHelper
def time_difference(difference)
    seconds    =  (difference % 60).to_i
    difference = (difference - seconds) / 60
    minutes    =  (difference % 60).to_i
    difference = (difference - minutes) / 60
    hours      =  (difference % 24).to_i
  
    [hours, minutes, seconds]
  
#    if hours > 0
#    "#{hours} hours #{minutes} min"
#    elsif hours = 0 and minutes > 0
#      "#{minutes} min #{seconds} sec"
 #   elsif hours = 0 and minutes == 0
 #     "#{seconds} sec"
 #   end
   
  end
  
  def hours(difference)
    hours = time_difference(difference).first
    if hours.to_i < 10
      "0" + hours.to_s
    else
     hours.to_s 
    end 
  end
  def min(difference)
    min = time_difference(difference).at(1)
    if min.to_i < 10
      "0" + min.to_s
    else
     min.to_s 
    end 
  end
  def sec(difference) 
    sec = time_difference(difference).last
    if sec.to_i < 10
      "0" + sec.to_s
    else
     sec.to_s 
    end 
  end
end
