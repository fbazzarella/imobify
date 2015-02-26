require 'rails_helper'

RSpec.describe User, type: :model do
  it { should belong_to(:account) }

  %i(account_id username).each do |field|
    it { should validate_presence_of(field) }
  end

  it { should validate_uniqueness_of(:username).scoped_to(:account_id) }

  it { should validate_presence_of(:password) }
  it { should validate_confirmation_of(:password) }
  it { should validate_length_of(:password).is_at_least(6).is_at_most(24) }
end
