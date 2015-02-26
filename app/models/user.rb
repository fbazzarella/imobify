class User < ActiveRecord::Base
  devise :database_authenticatable

  belongs_to :account

  validates :account_id, presence: true

  validates :username, presence: true, uniqueness: {scope: :account_id}

  validates :password, presence: true, confirmation: true, length: {within: 6..24}
end
