class Request < ActiveRecord::Base

  belongs_to :user

  def self.get_queryable_fields
    []
  end

  def on_create

  end

  def on_update

  end

end
