class User
  include Mongoid::Document
  include Mongoid::Timestamps
  field :facebook_id, type: String
  field :auth_token, type: String
  field :email, type: String
  field :first_name, type: String
  field :last_name, type: String

  field :cell_number, type: String
  
  has_many :events
  has_many :suggestions
  has_many :suggestion_messages
  has_many :responses
  
  has_many :invites, inverse_of: :invited_user
  
  def easy_name
    first_name + " " +  last_name[0 ... 1]
  end

end
