require 'rails_helper'

describe 'time_sheet#show' do
  before :each do
    @hiwi = FactoryGirl.create(:hiwi)
    @wimi = FactoryGirl.create(:wimi).user
    @wimi.update_attribute(:signature, 'wimi_signature')
    @contract = FactoryGirl.create(:contract, hiwi: @hiwi, responsible: @wimi)
    @time_sheet = FactoryGirl.create(:time_sheet, contract: @contract, handed_in: true, status: 'pending')
    login_as @wimi
  end

  it 'is possible to accept a time sheet' do
    visit time_sheet_path(@time_sheet)
    expect(page).to have_selector(:link_or_button, I18n.t('time_sheets.show_footer.accept'))
    click_on I18n.t('time_sheets.show_footer.accept')
    expect(page).to have_current_path(time_sheet_path(@time_sheet))
    expect(page).to have_content(I18n.t("activerecord.attributes.time_sheet.status_enum.accepted"))
    expect(page).to have_success_flash_message
    expect(page).to_not have_danger_flash_message
  end

  it 'there are no accept / reject buttons for an accepted time sheet' do
    @ts_accepted = FactoryGirl.create(:time_sheet,
      contract: @contract,
      signer: @wimi.id,
      handed_in: true,
      status: 'accepted')
    visit time_sheet_path(@ts_accepted)
    expect(page).to have_content(I18n.t("activerecord.attributes.time_sheet.status_enum.accepted"))
    expect(page).to_not have_selector(:link_or_button, I18n.t('time_sheets.show_footer.accept'))
    expect(page).to_not have_selector(:link_or_button, I18n.t('time_sheets.show_footer.reject'))
  end

  it 'is possible to reject a time sheet' do
    visit time_sheet_path(@time_sheet)
    expect(page).to have_selector(:link_or_button, I18n.t('time_sheets.show_footer.reject'))
    click_on I18n.t('time_sheets.show_footer.reject')
    expect(page).to have_current_path(time_sheet_path(@time_sheet))
    expect(page).to have_content(I18n.t("activerecord.attributes.time_sheet.status_enum.rejected"))
    expect(page).to have_success_flash_message
    expect(page).to_not have_danger_flash_message
  end

  it 'there are no accept / reject buttons for a rejected time sheet' do
    @ts_rejected = FactoryGirl.create(:time_sheet,
      contract: @contract,
      signer: @wimi.id,
      handed_in: true,
      status: 'rejected')
    visit time_sheet_path(@ts_rejected)
    expect(page).to have_content(I18n.t("activerecord.attributes.time_sheet.status_enum.rejected"))
    expect(page).to_not have_selector(:link_or_button, I18n.t('time_sheets.show_footer.reject'))
    expect(page).to_not have_selector(:link_or_button, I18n.t('time_sheets.show_footer.accept'))
  end

  # Regression tests for https://github.com/hpi-swt2/wimi-portal/issues/515
  context "handing in a previously signed sheet again after it was rejected" do

    before :each do
      @time_sheet.update_attributes(signed: true)
      visit time_sheet_path(@time_sheet)
      click_on I18n.t('time_sheets.show_footer.reject')
      login_as @hiwi
      visit time_sheet_path(@time_sheet)
    end

    it 'is possible without adding a signature ' do
      pending "Skipped until #515 is fixed"

      click_on I18n.t('helpers.links.hand_in')
    end

    it 'is possible to re-add the signature ' do
      pending "Skipped until #515 is fixed"

      check(I18n.t('time_sheets.show_footer.add_signature'))
      click_on I18n.t('helpers.links.hand_in')
    end
  end
end
