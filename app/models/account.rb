class Account < ActiveRecord::Base
  has_one  :site_settings, dependent: :delete, class_name: 'SiteSetting'
  has_many :domains,       dependent: :restrict_with_error
  has_many :users,         dependent: :restrict_with_error
  has_many :realties,      dependent: :restrict_with_error

  validates :name, :phone, :email, presence: true, length: {maximum: 255}

  validates :email,  format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}
  validates :mobile, length: {maximum: 255}

  def self.find_by_domain!(host)
    joins(:domains).where(domains: {host: host}).first!
  end
end
