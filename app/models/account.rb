class Account < ActiveRecord::Base
  has_many :domains,  dependent: :restrict_with_error
  has_many :users,    dependent: :restrict_with_error
  has_many :realties, dependent: :restrict_with_error

  validates :name, presence: true, length: {maximum: 255}

  def self.by_host(host)
    joins(:domains).where(domains: {host: host}).first || raise(ActiveRecord::RecordNotFound)
  end
end
