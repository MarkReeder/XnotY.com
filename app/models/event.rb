class Event
  include Mongoid::Document
  field :title, type: String
  field :description, type: String
  field :startRange, type: DateTime
  field :endRange, type: DateTime
end
