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
end
