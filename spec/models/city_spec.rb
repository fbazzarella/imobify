require 'rails_helper'

RSpec.describe City, type: :model do
  it { should belong_to(:country) }

  it { should have_many(:realties).dependent(:restrict_with_error) }

  %i(country_id name slug).each do |field|
    it { should validate_presence_of(field) }
  end
    
  %i(name slug).each do |field|
    it { should ensure_length_of(field).is_at_most(255) }
  end
end
