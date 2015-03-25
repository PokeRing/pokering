class Notification < ActiveRecord::Base

  serialize :content, JSON
  belongs_to :user
  after_create :send_external_notifications

  def self.get_queryable_fields
    []
  end

  def on_create

  end

  def on_update

  end

  def send_external_notifications
  	user = User.find_by(id: self.to_id)
  end

end
