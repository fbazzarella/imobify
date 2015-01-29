require 'rails_helper'

RSpec.describe RealtyHelper, type: :helper do
  describe 'cover_path_for' do
    context 'when any cover exists' do
      let!(:photo) { create(:photo) }

      subject { cover_path_for(photo.realty, :admin_cover) }

      it { expect(subject).to be_eql(photo.file.admin_cover.url) }
    end

    context 'when none cover exists' do
      let!(:realty) { create(:realty) }

      it { expect(cover_path_for(realty, :admin_cover)).to match(/no_cover_bg.png/) }
    end
  end
end
