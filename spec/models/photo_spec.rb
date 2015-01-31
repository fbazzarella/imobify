require 'rails_helper'

RSpec.describe Photo, type: :model do
  it { should belong_to(:realty) }

  it { should validate_presence_of(:realty_id) }

  it { should ensure_length_of(:uuid).is_at_most(255) }

  describe 'callbacks' do
    describe 'before_save' do
      let!(:photo) { create(:photo) }

      it { expect(photo.uuid).to_not be_nil }
    end
  end

  describe '.to_json' do
    let!(:photo) { create(:photo) }

    subject { photo.to_json }

    it { expect(subject[:id]).to         be_eql(photo.id) }
    it { expect(subject[:thumb_url]).to  be_eql(photo.file.admin_thumb.url) }
    it { expect(subject[:normal_url]).to be_eql(photo.file.admin_normal.url) }
  end
end
