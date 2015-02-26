class Domain < ActiveRecord::Base
  belongs_to :account

  validates :account_id, presence: true

  validates :host, presence: true, uniqueness: true, length: {maximum: 255}
end
