require 'rails_helper'

RSpec.describe Account, type: :model do
  it { should have_many(:users).dependent(:restrict_with_error) }

  it { should validate_presence_of(:name) }

  it { should validate_length_of(:name).is_at_most(255) }
end
