require 'rails_helper'

RSpec.describe Domain, type: :model do
  it { should belong_to(:account) }

  %i(account_id host).each do |field|
    it { should validate_presence_of(field) }
  end

  it { should validate_uniqueness_of(:host) }

  it { should validate_length_of(:host).is_at_most(255) }

  it { should allow_value('domain.com').for(:host) }
  it { should_not allow_value('invalid').for(:host) }
  it { should_not allow_value('domain@invalid').for(:host) }
end
