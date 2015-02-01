class Trip < ActiveRecord::Base

  serialize :users, JSON
  belongs_to :user

  def self.get_queryable_fields
    ['location']
  end

end
