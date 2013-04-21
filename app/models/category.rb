# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Category < ActiveRecord::Base
  attr_accessible :description, :name, :identity
  has_many :places
  
  
  def self.normalize(name)
    name.downcase.delete(' ')
  end
end
