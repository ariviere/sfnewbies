# == Schema Information
#
# Table name: places
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  location    :string(255)
#  description :string(255)
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  image       :string(255)
#  latitude    :float
#  longitude   :float
#  gmaps       :boolean
#

class Place < ActiveRecord::Base
  attr_accessible :description, :location, :name, :category_id, :image
  belongs_to :category
  has_many :comments, dependent: :destroy
  
  mount_uploader :image, ImageUploader

  acts_as_gmappable

  def gmaps4rails_address
    "#{self.location}, San Francisco, United States" 
  end
  
  def gmaps4rails_infowindow
    "#{self.name}"
  end
  
  
end
