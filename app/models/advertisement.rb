class Advertisement < ActiveRecord::Base
  has_many :comments
end
