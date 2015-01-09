require 'rails_helper'

RSpec.describe Realty, type: :model do
  it { should belong_to(:city) }

  it { should ensure_length_of(:reference).is_at_most(255) }
end
