class Ring < ActiveRecord::Base

  serialize :users, JSON
  belongs_to :user

  def self.get_queryable_fields
    ['title']
  end

  def on_create

  end

  def on_update

  end

end
