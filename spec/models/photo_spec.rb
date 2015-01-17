require 'rails_helper'

RSpec.describe Photo, type: :model do
  it { should belong_to(:realty) }

  it { should validate_presence_of(:realty_id) }

  describe '.to_json' do
    let!(:photo) { create(:photo) }

    subject { photo.to_json }

    it { expect(subject[:id]).to        be_eql(photo.id) }
    it { expect(subject[:thumb_url]).to be_eql(photo.file.admin.thumb.url) }
  end
end
