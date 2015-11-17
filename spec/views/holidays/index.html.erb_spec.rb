require 'rails_helper'

RSpec.describe 'holidays/index', type: :view do
  before(:each) do
  	user1 = FactoryGirl.create(:user)
  	user2 = FactoryGirl.create(:user)
  	sign_in user1
    assign(:holidays, [
      Holiday.create!(status: 'Holiday', user_id: user1.id),
      Holiday.create!(status: 'Holiday', user_id: user2.id)
    ])
  end

  it 'renders a list of holidays' do
    render
    assert_select "tr>td", text: "Holiday".to_s, count: 1
  end
end
