class SiteSetting < ActiveRecord::Base
  belongs_to :account, required: true

  validates :title, :logo, :template, presence: true, length: {maximum: 255}
end
