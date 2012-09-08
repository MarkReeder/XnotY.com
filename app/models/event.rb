class Event
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :description, type: String
  field :startRange, type: DateTime
  field :endRange, type: DateTime
end
