require 'rails_helper'

describe 'password updating for the superadmin' do
  before :each do
    @superadmin = FactoryGirl.create(:user, superadmin: true, username: 'admin', password: 'myadminpassword')
    @old_encrypted_password = @superadmin.encrypted_password

    login_as @superadmin
    visit user_path(@superadmin)
    expect(page).to have_content 'Change Password'
  end

  it 'should update with valid current password' do
    fill_in 'user_current_password', with: @superadmin.password
    fill_in 'user_password', with: 'newpassword'
    fill_in 'user_password_confirmation', with: 'newpassword'
    click_on 'Update Password'

    expect(page).to have_content 'Your account has been updated successfully.'
    @superadmin.reload
    expect(@superadmin.encrypted_password).to_not eq @old_encrypted_password
  end

  it 'should not update with invalid current password' do
    fill_in 'user_current_password', with: 'invalid_current_password'
    fill_in 'user_password', with: 'newpassword'
    fill_in 'user_password_confirmation', with: 'newpassword'
    click_on 'Update Password'

    expect(page).to_not have_content 'Your account has been updated successfully.'
    @superadmin.reload
    expect(@superadmin.encrypted_password).to eq @old_encrypted_password
  end

  it 'should not update with invalid password confirmation' do
    fill_in 'user_current_password', with: @superadmin.password
    fill_in 'user_password', with: 'newpassword'
    fill_in 'user_password_confirmation', with: 'invalid_password_confirmation'
    click_on 'Update Password'

    expect(page).to_not have_content 'Your account has been updated successfully.'
    @superadmin.reload
    expect(@superadmin.encrypted_password).to eq @old_encrypted_password
  end

  it 'should login with the new password' do
    click_on 'Logout'

    @superadmin.update(password: 'thenewpassword')
    visit superadmin_path

    fill_in 'user_username', with: @superadmin.username
    fill_in 'user_password', with: 'thenewpassword'
    click_on 'Log in'

    expect(page).to_not have_content 'Please sign in'
    expect(page).to have_content 'Logout'
  end
end

describe 'password updating for other users' do
  it 'should not show the password fields for other users' do
    user = FactoryGirl.create(:user)
    login_as user
    visit edit_user_path(user)
    expect(page).to_not have_content 'Change Password'
  end
end
