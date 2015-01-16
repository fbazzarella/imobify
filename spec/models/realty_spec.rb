require 'rails_helper'

RSpec.describe Realty, type: :model do
  it { should belong_to(:country) }
  it { should belong_to(:city) }

  it { should validate_presence_of(:country_id) }
  it { should validate_presence_of(:city_id) }

  described_class::BUSINESS_KIND.each do |bk|
    it { should allow_value(bk).for(:business_kind) }
  end

  it { should_not allow_value('other').for(:business_kind) }

  described_class::REALTY_KIND.each do |rk|
    it { should allow_value(rk).for(:realty_kind) }
  end

  it { should_not allow_value('other').for(:realty_kind) }

  it { should validate_uniqueness_of(:reference).allow_nil }

  %i(rooms bathrooms parking_spaces size price taxes).each do |field|
    it { should validate_numericality_of(field).only_integer.allow_nil }
  end

  %i(reference neighborhood street business_kind realty_kind).each do |field|
    it { should ensure_length_of(field).is_at_most(255) }
  end
end
