class Invite < ActiveRecord::Base

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
    Notification.create(
      type_id: 'invite.created',
      to_id: invited_id,
      content: {
        :subject_type => parent_type,
        :subject_id => parent_id,
        :subject => subject,
        :from_id => creator_id,
        :from => "#{from.first_name} #{from.last_name}"
      },
      status: 'unread'
    )
  end

  def on_update

  end

end
