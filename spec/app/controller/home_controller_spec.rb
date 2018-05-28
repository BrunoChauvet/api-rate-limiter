require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  it 'successfuly processes the request' do
    get :index

    expect(response).to be_success
  end
end
