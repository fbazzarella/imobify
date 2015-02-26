require 'rails_helper'

RSpec.describe Account, type: :model do
  %i(users realties).each do |association|
    it { should have_many(association).dependent(:restrict_with_error) }
  end

  it { should validate_presence_of(:name) }

  it { should validate_length_of(:name).is_at_most(255) }
end
