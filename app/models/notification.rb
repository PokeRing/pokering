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
  	if user.notify_via == 'email'
  	  EmailNotifications.sendto(self, user).deliver
  	elsif user.notify_via == 'mobile'
      # TODO implement mobile delivery when dealing with mobile app, text messaging, etc.
  	end
  end

end
