require 'rails_helper'

RSpec.describe City, type: :model do
  it { should belong_to(:country) }

  it { should have_many(:realties).dependent(:restrict_with_error) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:slug) }

  it { should ensure_length_of(:name).is_at_most(255) }
  it { should ensure_length_of(:slug).is_at_most(255) }
end
