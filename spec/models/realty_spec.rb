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

  describe '.location' do
    context 'when neighborhood is empty' do
      let!(:realty) { create(:realty) }

      it { expect(realty.location).to be_eql('Rio de Janeiro, RJ') }
    end

    context 'when neighborhood is filled' do
      let!(:realty) { create(:realty, neighborhood: 'Copacabana') }

      it { expect(realty.location).to be_eql('Copacabana, Rio de Janeiro, RJ') }
    end
  end

  describe '.cover_url' do
    context 'when realty have any photo' do
      let!(:photo)  { create(:photo) }
      let!(:realty) { create(:realty, photos: [photo]) }

      it { expect(realty.cover_url).to be_eql(photo.file.admin_cover.url) }
    end

    context 'when realty have none photo' do
      let!(:realty) { create(:realty) }

      it { expect(realty.cover_url).to be_nil }
    end
  end

  describe '.kind' do
    context 'when kind is empty' do
      let!(:realty) { create(:realty) }

      it { expect(realty.kind).to be_nil }
    end

    context 'when kind is filled' do
      let!(:realty) { create(:realty, business_kind: 'sale', realty_kind: 'house') }

      it do
        i18n = I18n.t('activerecord.collections.realty')

        bk = i18n[:business_kind][:sale]
        rk = i18n[:realty_kind][:house]

        expect(realty.kind).to be_eql("#{rk} #{bk}")
      end
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

  describe '.published?' do
    context 'when published' do
      let!(:realty) { create(:realty, published: true) }

      it { expect(realty.published?).to be_truthy }
    end

    context 'when not published' do
      let!(:realty) { create(:realty) }

      it { expect(realty.published?).to be_falsy }
    end
  end

  describe '.deactivate!' do
    let!(:realty) { create(:realty) }

    before { realty.deactivate! }

    it { expect(realty.deactivated_at).to_not be_nil }
  end

  describe '.deactivated?' do
    let!(:realty) { create(:realty) }

    context 'when activated' do
      it { expect(realty.deactivated?).to be_falsy }
    end

    context 'when deactivated' do
      before { realty.touch(:deactivated_at) }

      it { expect(realty.deactivated?).to be_truthy }
    end
  end
end
