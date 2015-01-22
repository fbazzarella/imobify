require 'rails_helper'

RSpec.describe Realty, type: :model do
  %i(country city).each do |association|
    it { should belong_to(association) }
  end

  it { should have_many(:photos).dependent(:destroy) }

  %i(country_id city_id).each do |field|
    it { should validate_presence_of(field) }
  end

  described_class::BUSINESS_KIND.each do |bk|
    it { should allow_value(bk).for(:business_kind) }
  end

  described_class::REALTY_KIND.each do |rk|
    it { should allow_value(rk).for(:realty_kind) }
  end

  %i(business_kind realty_kind).each do |field|
    it { should_not allow_value('other').for(field) }
  end

  described_class::NUMERIC_FIELDS.each do |field|
    it { should validate_numericality_of(field).only_integer.allow_nil }
  end

  described_class::TEXT_FIELDS.each do |field|
    it { should ensure_length_of(field).is_at_most(255) }
  end

  describe '#new_with_last_locations' do
    subject { described_class.new_with_last_locations }

    it { expect(subject).to be_a_new(Realty) }

    context 'when at least one realty exists' do
      let!(:realty) { create(:realty) }

      it { expect(subject.country_id).to be_eql(realty.country_id) }
      it { expect(subject.city_id).to    be_eql(realty.city_id) }
    end

    context 'when none realty exists' do
      it { expect(subject.country_id).to be_nil }
      it { expect(subject.city_id).to be_nil }
    end
  end

  describe '.locations' do
    let!(:city)   { create(:city) }
    let!(:realty) { create(:realty, country: city.country, city: city) }

    subject { realty.locations }

    it { expect(subject).to be_a(Hash) }

    it { expect(subject[:countries]).to include(realty.country) }
    it { expect(subject[:cities]).to    include(realty.city) }
  end

  describe '.cover_url' do
    context 'when realty have any photo' do
      let!(:photo)  { create(:photo) }
      let!(:realty) { create(:realty, photos: [photo]) }

      it { expect(realty.cover_url).to be_eql(photo.file.admin.cover.url) }
    end

    context 'when realty have none photo' do
      let!(:realty) { create(:realty) }

      it { expect(realty.cover_url).to be_nil }
    end
  end

  describe '.really_new?' do
    let!(:realty) { create(:realty) }

    context 'yep' do
      it { expect(realty).to be_really_new }
    end

    context 'nop' do
      before { realty.touch(:updated_at) }

      it { expect(realty).to_not be_really_new }
    end
  end
end
