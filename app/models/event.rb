class Event
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :description, type: String
  field :startRange, type: DateTime
  field :endRange, type: DateTime

  belongs_to :user
  has_many :suggestions
  has_many :invites

  def is_user_attending?(user)
    return false if user.nil?
    return true  if is_organizer?(user)
    invite = Invite.where(user_id: user._id, event_id: self._id).first
    !invite.nil?
  end

  def is_organizer?(user)
    user._id == self.user_id
  end
end
