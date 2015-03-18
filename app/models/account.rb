class Account < ActiveRecord::Base
  has_many :domains,       dependent: :restrict_with_error
  has_many :users,         dependent: :restrict_with_error
  has_many :realties,      dependent: :restrict_with_error
  has_one  :site_settings, dependent: :restrict_with_error, class_name: 'SiteSetting'

  validates :name, :theme, :phone, :email, presence: true

  validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}

  validates :name, :theme, :phone, :mobile, :email, length: {maximum: 255}

  def self.find_by_domain!(host)
    joins(:domains).where(domains: {host: host}).first!
  end
end
