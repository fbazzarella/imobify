class City < ActiveRecord::Base
  belongs_to :country, required: true

  has_many :realties, dependent: :restrict_with_error

  validates :name, :slug, presence: true, length: {maximum: 255}

  scope :with_published_realties,
    -> { distinct.joins(:realties).where(realties: {status: 'published'}).order(:name) }

  def full_name
    [name, slug.split('-').last.upcase].join(' - ')
  end
end
