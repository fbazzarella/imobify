require 'rails_helper'

RSpec.describe Photo, type: :model do
  it { should belong_to(:realty) }

  it { should validate_presence_of(:realty_id) }
end
