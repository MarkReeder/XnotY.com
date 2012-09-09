class Invite
  include Mongoid::Document
  include Mongoid::Timestamps

  field :email, type: String
  field :is_active, type: Boolean

  belongs_to :invited_user, class_name: "User"
  
  belongs_to :event
end
