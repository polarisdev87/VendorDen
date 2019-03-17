require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe 'GET index' do
    it "renders the index template" do
      get :index
    end
  end
end
