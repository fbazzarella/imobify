require 'rails_helper'

RSpec.describe SiteSetting, type: :model do
  it { should belong_to(:account) }

  %i(account title logo template).each do |field|
    it { should validate_presence_of(field) }
  end

  %i(title logo template).each do |field|
    it { should validate_length_of(field).is_at_most(255) }
  end
end
