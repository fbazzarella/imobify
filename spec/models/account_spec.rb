require 'rails_helper'

RSpec.describe Account, type: :model do
  %i(domains users realties).each do |association|
    it { should have_many(association).dependent(:restrict_with_error) }
  end

  it { should validate_presence_of(:name) }

  it { should validate_length_of(:name).is_at_most(255) }

  describe '#by_host' do
    context 'when the domain exist' do
      let!(:domain1) { create(:domain) }
      let!(:domain2) { create(:domain) }

      let!(:account1) { create(:account, domains: [domain1]) }
      let!(:account2) { create(:account, domains: [domain2]) }

      subject { described_class.by_host(domain1.host) }

      it { expect(subject).to be_eql(account1) }
    end

    context 'when the domain do not exist' do
      let!(:account) { create(:account) }

      subject { described_class.by_host('do.not.exist') }

      it { expect{ subject }.to raise_error(ActiveRecord::RecordNotFound) }
    end
  end
end
