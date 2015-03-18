require 'rails_helper'

RSpec.describe City, type: :model do
  it { should belong_to(:country) }

  it { should have_many(:realties).dependent(:restrict_with_error) }

  %i(country name slug).each do |field|
    it { should validate_presence_of(field) }
  end
    
  %i(name slug).each do |field|
    it { should validate_length_of(field).is_at_most(255) }
  end

  describe 'scopes' do
    describe '#with_published_realties' do
      let!(:city1) { create(:city) }
      let!(:city2) { create(:city) }

      let!(:realty1) { create(:realty, city: city1, status: 'published') }
      let!(:realty2) { create(:realty, city: city1, status: 'published') }
      let!(:realty3) { create(:realty, city: city2) }

      subject { described_class.with_published_realties }

      it { expect(subject.count).to be_eql(1) }
      it { expect(subject).to include(city1) }
    end
  end

  describe '.full_name' do
    let!(:city) { create(:city) }

    it { expect(city.full_name).to be_eql('Rio de Janeiro - RJ') }
  end
end
