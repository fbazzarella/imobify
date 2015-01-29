require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'menu_link_to' do
    it { expect(menu_link_to('Test')).to match /Test/ }
  end

  describe 'to_currency' do
    it { expect(to_currency(1000)).to be_eql('R$1.000,00') }
  end
end
