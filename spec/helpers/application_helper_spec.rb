require 'spec_helper'

describe ApplicationHelper do
  describe 'menu_link_to' do
    it { expect(menu_link_to('Test')).to match /Test/ }
  end
end
