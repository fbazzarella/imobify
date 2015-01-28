require 'rails_helper'

RSpec.describe RealtiesController, type: :controller do
  render_views

  describe 'GET #index' do
    let!(:realty) { create(:realty) }

    before { get :index }

    it { expect(assigns(:realties)).to be_a(ActiveRecord::Relation) }
    it { expect(assigns(:realties)).to include(realty) }

    it { is_expected.to respond_with 200 }
  end
end
