require 'rails_helper'

RSpec.describe Country, type: :model do
  it { should have_many(:cities).dependent(:restrict_with_error) }
  it { should have_many(:realties).dependent(:restrict_with_error) }

  it { should validate_presence_of(:initial) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:slug) }

  it { should ensure_length_of(:initial).is_equal_to(2) }
  it { should ensure_length_of(:name).is_at_most(255) }
  it { should ensure_length_of(:slug).is_at_most(255) }

  describe '#all_with_cities_by' do
    let!(:country1) { create(:country, slug: 'country-1') }
    let!(:country2) { create(:country, slug: 'country-2') }

    let!(:country1_city) { create(:city, country: country1) }
    let!(:country2_city) { create(:city, country: country2) }

    subject { described_class.all_with_cities_by(country2) }

    it { expect(subject).to be_a(Hash) }
    it { expect(subject[:countries]).to include(country1, country2) }
    it { expect(subject[:cities]).to include(country2_city) }
    it { expect(subject[:cities]).to_not include(country1_city) }

    context 'when none country is passed' do
      subject { described_class.all_with_cities_by(nil) }

      it { expect(subject[:cities]).to include(country1_city) }
      it { expect(subject[:cities]).to_not include(country2_city) }
    end
  end
end
