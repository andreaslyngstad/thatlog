module ApplicationHelper
	def pick_color
    a = ["red", "Orange", "Yellow ", "Green ", "Blue", "Indigo", "Violet", "#51E86F"]
    return a
  end
  
	def truncate_string(text, length = 18, truncate_string = '...')
     if text.nil? then return end
     l = length - truncate_string.length
     text.length > length ? text[0...l] + truncate_string : text
	end

	def image(person, css_class)
		if person.avatar_file_name.nil?
			image_tag("http://www.gravatar.com/avatar/#{Digest::MD5::hexdigest(person.email)}?default=mm&s=100", :alt => 'Avatar', :class => css_class)
		else
			if css_class == "image32"
				image_tag person.avatar.url(:small), :class => css_class
			elsif css_class == "image100" or css_class == "image64"
				image_tag person.avatar.url(:original), :class => css_class	
			end
		end
	end
	def time_diff(time)
  	seconds    	=  (time % 60).to_i
    time 		= (time - seconds) / 60
    minutes    	=  (time % 60).to_i
    time 		= (time - minutes) / 60
    hours      	=  (time).to_i
    if minutes == 0 
    	return hours.to_s + ":00"
    elsif minutes < 10
    	return hours.to_s + ":0" + minutes.to_s
	else
  		return hours.to_s + ":" + minutes.to_s
  	end
  end
	def done_not_done(done_todos, not_done_todos)
  	done = done_todos.count
  	not_done = not_done_todos.count	
  	donepr = (done / (done + not_done).to_f)*100
  	not_donepr = (not_done / (done + not_done).to_f)*100
  	 donepr.round(2).to_s + "%"
  	 #image_tag("https://chart.googleapis.com/chart?cht=p&chs=200x125&chco=FAAABE|ADFAAA&chd=t:#{not_donepr},#{donepr}&chdl=Not%20done%20tasks|Done%20tasks", :style => {:width => 200, :height=>125} )
  end
 	def url_splitter(url)
 		url.split("/").second
 	end	 
 	def url_splitter2(url)
 		url.split("/").third
 	end	 
  #for devise
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
