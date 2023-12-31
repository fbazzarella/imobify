class Realty < ActiveRecord::Base
  BUSINESS_KIND = %w(sale rental vacation_rental)
  REALTY_KIND   = %w(house apartment kitchenette room store terrain country_house site farm)
  STATUS        = %w(published draft deactivated)

  NUMERIC_FIELDS   = %i(rooms bathrooms parking_spaces size price taxes)
  TEXT_FIELDS      = %i(neighborhood street business_kind realty_kind status reference)
  PERMITTED_FIELDS = NUMERIC_FIELDS + TEXT_FIELDS + %i(country_id city_id description)

  acts_as_tenant :account

  belongs_to :country, required: true
  belongs_to :city,    required: true

  has_many :photos, dependent: :destroy

  validates :account, presence: true
  validates :views,   presence: true, numericality: {only_integer: true}

  validates :business_kind, inclusion: BUSINESS_KIND, allow_nil: true
  validates :realty_kind,   inclusion: REALTY_KIND,   allow_nil: true
  validates :status,        inclusion: STATUS,        allow_nil: true

  validates *NUMERIC_FIELDS, numericality: {only_integer: true}, allow_nil: true
  validates *TEXT_FIELDS,    length: {maximum: 255}

  scope :published, -> { where(status: 'published') }

  %i(business_kind realty_kind city_id rooms parking_spaces).each do |field|
    scope "by_#{field}".to_sym, -> (value) { where(field => value) if value.present? }
  end

  class << self
    def new_with_last_locations
      any? ? new(last.attributes.extract!('country_id', 'city_id')) : new
    end

    def find_and_count(id)
      find(id).tap { |r| r.increment! :views }
    end
  end

  def related_realties
    self.class.published.by_city_id(city_id).by_business_kind(business_kind).where.not(id: id)
  end

  def locations
    Country.all_with_cities_by(country)
  end

  def location
    [neighborhood, city.full_name].reject(&:blank?).join(' - ')
  end

  def full_location
    [street, location].reject(&:blank?).join(' - ')
  end

  def cover_url(version)
    photo = photos.first
    photo.file.send(version).url if photo.present?
  end

  def kind
    return if realty_kind.blank? || business_kind.blank?

    i18n = I18n.t('activerecord.collections.realty')

    bk = i18n[:business_kind][business_kind.to_sym]
    rk = i18n[:realty_kind][realty_kind.to_sym]

    [rk, bk].join(' ')
  end

  def have_summary?
    %i(rooms bathrooms parking_spaces size).each do |field|
      return true if send(field).present?
    end

    false
  end

  def publish!
    update_attribute(:status, 'published')
  end

  def published?
    status == 'published'
  end

  def deactivate!
    update_attribute(:status, 'deactivated')
  end

  def deactivated?
    status == 'deactivated'
  end
end
