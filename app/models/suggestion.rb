class Suggestion
  include Mongoid::Document
  include Mongoid::Timestamps
  field :description, type: String
  field :location, type: String
  field :time, type: DateTime
  after_create :notify_all
  
  has_many :responses
  belongs_to :user
  belongs_to :event
  has_many :suggestion_messages

  def notify_all
    users = event.invites.map(&:invited_user) + [event.user]
    # don't send to the suggestion creator
    users = users.reject{|u| u._id == self.user._id}.compact
    users.map do |user|
      message = SuggestionMessage.send_message(user, self)
    end
  end
end
