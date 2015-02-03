class Request < ActiveRecord::Base

  belongs_to :user

  def self.get_queryable_fields
    []
  end

  def on_create
    if parent_type == "games"
      subject_record = Game.find(parent_id)
      subject = subject_record.name
    end
    if parent_type == "trips"
      subject_record = Trip.find(parent_id)
      subject = subject_record.location
    end
    from = User.find(creator_id)
    referred = nil
    if referred_id
      referred_record = User.find(referred_id)
      referred = "#{referred_record.first_name} #{referred_record.last_name}"
    end
    Notification.create(
      type_id: "request.#{request_type}.created",
      to_id: to_id,
      content: {
        :subject_type => parent_type,
        :subject_id => parent_id,
        :subject => subject,
        :from_id => creator_id,
        :from => "#{from.first_name} #{from.last_name}",
        :referred_id => referred_id,
        :referred => referred
      },
      status: 'unread'
    )
  end

  def on_update

  end

end
