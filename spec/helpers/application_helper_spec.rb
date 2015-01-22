require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'menu_link_to' do
    it { expect(menu_link_to('Test')).to match /Test/ }
  end

  describe 'cover_path_for' do
    context 'when any cover exists' do
      let!(:photo) { create(:photo) }

      subject { cover_path_for(photo.realty) }

      it { expect(subject).to be_eql(photo.file.admin.cover.url) }
    end

    context 'when none cover exists' do
      let!(:realty) { create(:realty) }

      it { expect(cover_path_for(realty)).to match(/no_cover_bg.png/) }
    end
  end
end
