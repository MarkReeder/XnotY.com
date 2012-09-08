class Event
  include Mongoid::Document
  field :title, type: DString
  field :description, type: String
  field :startRange, type: Datetime
  field :endRange, type: Datetime
end
