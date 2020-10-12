# Non AR rails model that allows for AR like behavior including validations and attribute initialization
class User
  include ActiveModel::Model

  attr_accessor :username

  validates :username, presence: true
end