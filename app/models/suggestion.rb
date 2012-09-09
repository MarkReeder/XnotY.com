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
    (this.invites.map(&:invited_user) + [this.user]).map do |user|
      message = SuggestionMessage.send(user, this)
    end
  end
end
