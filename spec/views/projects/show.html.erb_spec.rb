require 'rails_helper'

RSpec.describe 'projects/show', type: :view do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @chair = FactoryGirl.create(:chair)
    @project = FactoryGirl.create(:project, chair: @chair)

    login_as @user
    allow(view).to receive(:current_user).and_return(@user)
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(@project.title)
  end

  it 'has information about the project on page as a chair representative' do
    representative = @chair.representative.user
    login_as representative
    project = FactoryGirl.create(:project, chair: @chair, status: true)
    representative.projects << project
    visit project_path(project)

    expect(page).to have_content(project.title)
    expect(page).to have_content(project.chair.name)
    expect(page).to_not have_content(I18n.t('projects.show.public'))
    
    # only because rep is also wimi of the project
    expect(page).to have_content(project.chair.representative.user.name)
  end

  context 'as hiwi without a valid contract' do
    before(:each) do
      @hiwi = @user
      login_as @hiwi
      @hiwi.projects << @project
      
      visit project_path(@project)
    end

    it 'has information about the project on page' do
      expect(page).to have_content(@project.title)
      expect(page).to have_content(@project.chair.name)
      expect(page).to_not have_content(I18n.t('projects.show.public'))
    end

    it 'does not show an add working hours button' do
      expect(page).to_not have_link(I18n.t('projects.show.add_working_hours'))
    end
  end

  context 'as wimi' do
    before(:each) do
      representative = @chair.representative.user
      @wimi = FactoryGirl.create(:wimi, user: FactoryGirl.create(:user), chair: @chair).user
      @wimi2 = FactoryGirl.create(:wimi, user: FactoryGirl.create(:user), chair: @chair).user
      @project = FactoryGirl.create(:project, chair: @chair, status: true)

      login_as @wimi
      visit project_path(@project)
    end

    it 'has information about the project on page' do
      expect(page).to have_content(@project.title)
      expect(page).to have_content(@project.chair.name)
      expect(page).to have_content(l(@project.created_at))
      expect(page).to_not have_content(I18n.t('projects.show.public'))
    end

    it 'shows no add working hours button' do
      @wimi.projects << @project
      visit current_path
      expect(page).to_not have_link(I18n.t('projects.show.add_working_hours'))
    end

    it "doesn't show a button to inspect a user's working hour report for all wimis" do
      user = FactoryGirl.create(:user)
      @wimi.projects << @project
      user.projects << @project
      visit current_path
      expect(page).to_not have_selector(:link_or_button, I18n.t('projects.form.show_current_timesheet'))
    end
    
    it 'not possible for wimi to edit if not a member' do
      visit current_path
      expect(page).not_to have_css("a[href='#{edit_project_path(@project)}']")
      expect(page).not_to have_delete_link(@project)
      expect(page).not_to have_selector(:link_or_button, I18n.t('projects.show.set_inactive'))
    end
  end
end
