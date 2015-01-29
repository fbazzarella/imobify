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

  described_class::STATUS.each do |st|
    it { should allow_value(st).for(:status) }
  end

  %i(business_kind realty_kind status).each do |field|
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

      it { expect(realty.cover_url(:admin_cover)).to be_eql(photo.file.admin_cover.url) }
    end

    context 'when realty have none photo' do
      let!(:realty) { create(:realty) }

      it { expect(realty.cover_url(:admin_cover)).to be_nil }
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

  describe '.have_summary?' do
    let!(:realty) { create(:realty) }

    context 'nop' do
      it { expect(realty).to_not be_have_summary }
    end

    context 'yep' do
      before { realty.update_attribute(:rooms, 1) }

      it { expect(realty).to be_have_summary }
    end
  end

  describe '.publish!' do
    let!(:realty) { create(:realty) }

    before { realty.publish! }

    it { expect(realty).to be_published }
  end

  describe '.published?' do
    context 'when published' do
      let!(:realty) { create(:realty, status: 'published') }

      it { expect(realty).to be_published }
    end

    context 'when not published' do
      let!(:realty) { create(:realty) }

      it { expect(realty).to_not be_published }
    end
  end

  describe '.deactivate!' do
    let!(:realty) { create(:realty) }

    before { realty.deactivate! }

    it { expect(realty).to be_deactivated }
  end

  describe '.deactivated?' do
    context 'when deactivated' do
      let!(:realty) { create(:realty, status: 'deactivated') }

      it { expect(realty).to be_deactivated }
    end

    context 'when activated' do
      let!(:realty) { create(:realty) }

      it { expect(realty).to_not be_deactivated }
    end
  end
end
