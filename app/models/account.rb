class Account < ActiveRecord::Base
  has_many :domains,       dependent: :restrict_with_error
  has_many :users,         dependent: :restrict_with_error
  has_many :realties,      dependent: :restrict_with_error
  has_one  :site_settings, dependent: :restrict_with_error, class_name: 'SiteSetting'

  validates :name, :theme, presence: true, length: {maximum: 255}

  def self.find_by_domain!(host)
    joins(:domains).where(domains: {host: host}).first!
  end
end
