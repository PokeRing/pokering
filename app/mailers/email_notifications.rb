class EmailNotifications < ActionMailer::Base
  default from: "notifications@getpokering.com"

  def sendto(notification, to)
  	@to = to
  	@notification = notification
  	mail(to: @to.email, subject: 'New PokeRing Notification')
  end
end
