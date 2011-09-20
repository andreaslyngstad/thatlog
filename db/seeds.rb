# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
puts "setting up first firm"
firm1 = Firm.create! :name => "lizz", :subdomain => "lizz"
puts 'New firm created: ' << firm1.name
firm2 = Firm.create! :name => "lekk betong", :subdomain => "lekk_betong"
puts 'New firm created: ' << firm2.name
puts 'SETTING UP EXAMPLE USERS'
user1 = User.create! :name => 'andreas lyngstad', :firm_id => "1", :email => 'andreas@lizz.no', :password => 'lekmedmeg', :password_confirmation => 'lekmedmeg', :manager => true
puts 'New user created: ' << user1.name
user2 = User.create! :name => 'Axel pharo', :firm_id => "2", :email => 'axel@lizz.no', :password => 'lekmedmeg', :password_confirmation => 'lekmedmeg', :manager => true
puts 'New user created: ' << user2.name
user3 = User.create! :name => 'Tiril Pharo', :firm_id => "1", :email => 'tiril@lizz.no', :password => 'lekmedmeg', :password_confirmation => 'lekmedmeg', :manager => false
puts 'New user created: ' << user3.name
user4 = User.create! :name => 'Astrid pharo', :firm_id => "2", :email => 'astrid@lizz.no', :password => 'lekmedmeg', :password_confirmation => 'lekmedmeg', :manager => false
puts 'New user created: ' << user4.name

puts "Setting up customers"
customers1 = Customer.create! :name => "Harald Bråhten", :firm_id => "1", :phone => "96979892", :email => "harald@braten.no"
puts 'New customer created: ' << customers1.name
customers2 = Customer.create! :name => "Jens Trand", :firm_id => "1", :phone => "96979892", :email => "jens@trand.no"
puts 'New customer created: ' << customers2.name
customers3 = Customer.create! :name => "Olav Hansen", :firm_id => "2", :phone => "96979892", :email => "olav@hansen.no"
puts 'New customer created: ' << customers3.name
customers4 = Customer.create! :name => "Trine Vind", :firm_id => "2", :phone => "96979892", :email => "Trine@vind.no"
puts 'New customer created: ' << customers4.name

puts "Setting up Employees"

employees1 = Employee.create! :name => "Per Bråhten", :customer_id => "1", :phone => "96979892", :email => "per@braten.no"
puts 'New employees created: ' << employees1.name
employees2 = Employee.create! :name => "Knut Bråhten", :customer_id => "1", :phone => "96979892", :email => "knut@braten.no"
puts 'New employees created: ' << employees2.name
employees3 = Employee.create! :name => "Per Trand", :customer_id => "2", :phone => "96979892", :email => "per@trand.no"
puts 'New employees created: ' << employees3.name
employees4 = Employee.create! :name => "Knut Trand", :customer_id => "2", :phone => "96979892", :email => "per@trand.no"
puts 'New employees created: ' << employees4.name
employees5 = Employee.create! :name => "Alf Hansen", :customer_id => "3", :phone => "96979892", :email => "per@hansen.no"
puts 'New employees created: ' << employees5.name
employees6 = Employee.create! :name => "Einar Hansen", :customer_id => "3", :phone => "96979892", :email => "per@hansen.no"
puts 'New employees created: ' << employees6.name
employees7 = Employee.create! :name => "Felix Vind", :customer_id => "4", :phone => "96979892", :email => "per@vind.no"
puts 'New employees created: ' << employees7.name
employees8 = Employee.create! :name => "Per Vind", :customer_id => "4", :phone => "96979892", :email => "per@vind.no"
puts 'New employees created: ' << employees8.name

puts "Setting up projects"
projects1 = Project.create! :name => "lizz", :firm_id => "1", :active => true, :due => Time.now + 3000000
puts 'New project created: ' << projects1.name
projects2 = Project.create! :name => "fix car", :firm_id => "1", :customer_id => "1", :active => true, :due => Time.now + 3000000
puts 'New project created: ' << projects2.name
projects3 = Project.create! :name => "fix moped", :firm_id => "1", :customer_id => "2", :active => true, :due => Time.now + 3000000
puts 'New project created: ' << projects3.name

projects4 = Project.create! :name => "clean house", :firm_id => "2", :active => true, :due => Time.now + 3000000
puts 'New project created: ' << projects4.name
projects5 = Project.create! :name => "fix barn", :firm_id => "2", :active => true, :due => Time.now + 3000000
puts 'New project created: ' << projects5.name
projects6 = Project.create! :name => "Paint fence", :firm_id => "2", :active => true, :due => Time.now + 3000000, :customer_id => "4"
puts 'New project created: ' << projects6.name

puts "Setting up todos"
todo1 = Todo.create! :name => "Sell music", :firm_id => "1", :project_id => "1", :due => Time.now + 3000000, :completed => false
puts 'New todo created: ' << todo1.name
todo2 = Todo.create! :name => "Fill water", :firm_id => "2", :project_id => "4", :due => Time.now + 3000000, :completed => false
puts 'New todo created: ' << todo2.name
todo3 = Todo.create! :name => "Record music", :firm_id => "1", :project_id => "1", :due => Time.now + 3000000, :completed => false
puts 'New todo created: ' << todo3.name
todo4 = Todo.create! :name => "Moan loan", :firm_id => "2", :project_id => "4", :due => Time.now + 3000000, :completed => false
puts 'New todo created: ' << todo4.name
todo5 = Todo.create! :name => "Camshaft", :firm_id => "1", :project_id => "2", :due => Time.now + 3000000, :completed => false
puts 'New todo created: ' << todo5.name
todo6 = Todo.create! :name => "Cyllinder", :firm_id => "1", :project_id => "2", :due => Time.now + 3000000, :completed => false
puts 'New todo created: ' << todo6.name

puts "Setting up logs"
time4daysago = Time.now - 4.days
time6daysago = Time.now - 6.days
timeyesterday = Time.now - 1.days
log1 = Log.create! :user_id => "1", :event => "Sell DDE", :firm_id => "1", :project_id => "1", :todo_id => "1", :tracking => false, :log_date => Time.now, :begin_time => Time.now, :end_time => Time.now + 1.hours
log2 = Log.create! :user_id => "1", :event => "Sell Dumdumboys", :firm_id => "1", :project_id => "1", :todo_id => "1", :tracking => false, :log_date => Time.now, :begin_time => Time.now + 1.hours, :end_time => Time.now + 3.hours
log3 = Log.create! :user_id => "1", :event => "Record nicolai", :firm_id => "1", :project_id => "1", :todo_id => "2", :tracking => false, :log_date => Time.now, :begin_time => Time.now + 3.hours, :end_time => Time.now + 5.hours
log4 = Log.create! :user_id => "1", :event => "Record slalom", :firm_id => "1", :project_id => "1", :todo_id => "2", :tracking => false, :log_date => Time.now, :begin_time => Time.now + 5.hours, :end_time => Time.now + 6.hours
log5 = Log.create! :user_id => "1", :event => "Making poster", :firm_id => "1", :project_id => "1", :tracking => false, :log_date => Time.now, :begin_time => Time.now + 1.hours, :end_time => Time.now + 3.hours
log6 = Log.create! :user_id => "2", :event => "Sell nicolai", :firm_id => "1", :project_id => "1", :tracking => false, :log_date => time4daysago, :begin_time => time4daysago, :end_time => time4daysago + 5.hours
log7 = Log.create! :user_id => "2", :event => "Sell nicolai", :firm_id => "1", :project_id => "1", :tracking => false, :log_date => time4daysago, :begin_time => time4daysago + 5.hours, :end_time => time4daysago + 7.hours
log8 = Log.create! :user_id => "2", :event => "Unscrew", :firm_id => "1", :project_id => "2", :todo_id => "5", :tracking => false, :log_date => time4daysago, :begin_time => time4daysago, :end_time => time4daysago + 1.hours
log9 = Log.create! :user_id => "2", :event => "Take wheel off", :firm_id => "1", :project_id => "2", :todo_id => "5", :tracking => false, :log_date => time6daysago, :begin_time => time6daysago + 3.hours, :end_time => time6daysago + 5.hours
log10 = Log.create! :user_id => "2", :event => "Remove spring", :firm_id => "1", :project_id => "2", :todo_id => "6", :tracking => false, :log_date => time6daysago, :begin_time => time6daysago + 5.hours, :end_time => time6daysago + 6.hours
log11 = Log.create! :user_id => "2", :event => "Take off hood", :firm_id => "1", :project_id => "2", :todo_id => "6", :tracking => false, :log_date => time6daysago, :begin_time => timeyesterday, :end_time => timeyesterday + 6.hours
 
logs = [log1, log2, log3, log4, log5, log6, log7, log8, log9, log10, log11]
logs.each do |log|
puts 'New logs created: ' <<  log.event  
end

puts "Setting up milestones"
milestone1 = Milestone.create! :goal => "Make music", :firm_id => "1", :project_id => "1", :due => Time.now + 3000000, :completed => false
puts 'New project created: ' << milestone1.goal
milestone2 = Milestone.create! :goal => "Record music", :firm_id => "1", :project_id => "1", :due => Time.now + 3100000, :completed => false
puts 'New project created: ' << milestone2.goal
milestone3 = Milestone.create! :goal => "Press music", :firm_id => "1", :project_id => "1", :due => Time.now + 3200000, :completed => false
puts 'New project created: ' << milestone3.goal
milestone4 = Milestone.create! :goal => "Sell music", :firm_id => "1", :project_id => "1", :due => Time.now + 3400000, :completed => false
puts 'New project created: ' << milestone4.goal


