class User
  include Mongoid::Document
  include Mongoid::Timestamps
  field :facebook_id, type: String
  field :auth_token, type: String
  field :email, type: String
  field :first_name, type: String
  field :last_name, type: String

  has_many :events
  has_many :suggestions
  has_many :votes
end
