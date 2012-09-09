class Response
  include Mongoid::Document
  include Mongoid::Timestamps

  field :vote, type: String
  
  belongs_to :user
  belongs_to :suggestion
end
