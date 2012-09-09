class Suggestion
  include Mongoid::Document
  include Mongoid::Timestamps
  field :description, type: String
  field :location, type: String
  field :time, type: DateTime
  
  has_many :responses
  belongs_to :user
end
