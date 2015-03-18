class User < ActiveRecord::Base
  devise :database_authenticatable

  acts_as_tenant :account

  validates :account, :username, :password, presence: true

  validates :username, uniqueness: {scope: :account_id}
  validates :password, confirmation: true, length: {within: 6..24}
end
