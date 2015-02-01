class Game < ActiveRecord::Base

  serialize :users, JSON
  belongs_to :user

  def self.get_queryable_fields
    ['name', 'location', 'info']
  end

end
