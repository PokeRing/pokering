class Comment < ActiveRecord::Base

  serialize :users, JSON
  belongs_to :user

  def self.get_queryable_fields
    ['comment']
  end

end
