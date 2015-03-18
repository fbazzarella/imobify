class SiteSetting < ActiveRecord::Base
  belongs_to :account

  validates :account_id, :title, :logo, :template, presence: true

  validates :title, :logo, :template, length: {maximum: 255}
end
