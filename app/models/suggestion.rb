class Suggestion
  include Mongoid::Document
  include Mongoid::Timestamps
  field :description, type: String
  
  has_many :responses
  belongs_to :user
end
