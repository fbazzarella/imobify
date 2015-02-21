require 'rails_helper'

RSpec.describe Country, type: :model do
  %i(cities realties).each do |association|
    it { should have_many(association).dependent(:restrict_with_error) }
  end

  %i(initial name slug).each do |field|
    it { should validate_presence_of(field) }
  end

  %i(name slug).each do |field|
    it { should validate_length_of(field).is_at_most(255) }
  end

  it { should validate_length_of(:initial).is_equal_to(2) }

  describe '#all_with_cities_by' do
    let!(:country1) { create(:country) }
    let!(:country2) { create(:country) }

    let!(:country1_city) { create(:city, country: country1) }
    let!(:country2_city) { create(:city, country: country2) }

    subject { described_class.all_with_cities_by(country2) }

    it { expect(subject[:countries]).to  include(country1, country2) }
    it { expect(subject[:cities]).to     include(country2_city) }
    it { expect(subject[:cities]).to_not include(country1_city) }

    context 'when none country is passed' do
      subject { described_class.all_with_cities_by(nil) }

      it { expect(subject[:cities]).to     include(country1_city) }
      it { expect(subject[:cities]).to_not include(country2_city) }
    end
  end
end
