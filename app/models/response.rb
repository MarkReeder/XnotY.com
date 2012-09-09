class Response
  include Mongoid::Document
  include Mongoid::Timestamps

  # for, against, neutral
  field :vote, type: Stringf
  
  belongs_to :user
  belongs_to :suggestion
end
