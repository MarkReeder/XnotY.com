class Event
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :description, type: String
  field :startRange, type: DateTime
  field :endRange, type: DateTime

  belongs_to :user
  has_many :suggestions
end
