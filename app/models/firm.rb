class Firm < ActiveRecord::Base
  
  has_many :customers 
  has_many :users
  has_many :todos
  has_many :logs
  has_many :projects
  validates_presence_of :name
  validates_presence_of :subdomain
  validates_format_of :subdomain, :with => /^[a-z0-9\_]+$/i
  validates_uniqueness_of :subdomain
end
