require 'rails_helper'

RSpec.describe 'holidays/show', type: :view do
  before(:each) do
  	user = FactoryGirl.create(:user)
    @holiday = assign(:holiday, Holiday.create!(user_id: user.id))
  end

  it 'renders attributes in <p>' do
    render
  end
end
