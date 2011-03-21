class Employee < ActiveRecord::Base
  belongs_to :customer
  has_many :logs
end
