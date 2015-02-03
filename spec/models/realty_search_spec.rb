require 'rails_helper'

RSpec.describe RealtySearch, type: :model do
  describe '.result' do
    let!(:realty1) { create(:realty, status: 'published', rooms: 1) }
    let!(:realty2) { create(:realty, status: 'published', rooms: 2) }
    let!(:realty3) { create(:realty, status: 'scratch', rooms: 2) }

    subject { described_class.new({rooms: 2}).result }

    it { expect(subject).to be_a(ActiveRecord::Relation) }
    it { expect(subject.first).to be_a(Realty) }

    it { expect(subject).to include(realty2) }
    it { expect(subject).to_not include(realty1, realty3) }
  end
end
