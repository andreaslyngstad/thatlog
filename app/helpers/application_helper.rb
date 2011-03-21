module ApplicationHelper
	include UrlHelper
	
  def pick_color
      a = ["red", "Orange", "Yellow ", "Green ", "Blue", "Indigo", "Violet", "#51E86F"]
      return a
    end
    
  def truncate_string(text, length = 18, truncate_string = '...')
     if text.nil? then return end
     l = length - truncate_string.length
     text.length > length ? text[0...l] + truncate_string : text
  end
  class MenuTabBuilder < TabsOnRails::Tabs::Builder
  def tab_for(tab, name, options, item_options = {})
    item_options[:class] = (current_tab?(tab) ? 'navigation active' : 'navigation') 
    item_options[:id] = name.downcase + "_navi"
    @context.content_tag(:li, item_options) do
      @context.link_to(name, options)
    end
  end
end

	def gravatar(person, css_class)
	image_tag("http://www.gravatar.com/avatar.php?gravatar_id=#{Digest::MD5::hexdigest(person.email)}", :alt => 'Avatar', :class => css_class)	
	end
	
	def done_not_done(done_todos, not_done_todos)
  	done = done_todos.count
  	not_done = not_done_todos.count	
  	donepr = (done / (done + not_done).to_f)*100
  	not_donepr = (not_done / (done + not_done).to_f)*100
  	 image_tag("https://chart.googleapis.com/chart?cht=p&chs=200x125&chco=FAAABE|ADFAAA&chd=t:#{not_donepr},#{donepr}&chdl=Not%20done%20tasks|Done%20tasks", :style => {:width => 200, :height=>125} )
  end
end
