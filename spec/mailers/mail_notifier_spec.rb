require "rails_helper"

RSpec.describe ApplicationMailer, type: :mailer do
  describe "notification" do

    let(:user) { FactoryGirl.create(:user) }
    let(:event) { FactoryGirl.create(:event, user: user, target_user: user) }
    let(:mail) { ApplicationMailer.notification(event, user) }

    it "renders the headers" do
      subj = I18n.t("application_mailer.notification.subject",
        text: I18n.t("event.user_friendly_name.#{event.type}")
      )
      expect(mail.subject).to eq(subj)
      expect(mail.to.count).to eq(1)
      expect(mail.to.first).to eq(user.email)
      expect(mail.from.count).to eq(1)
      # Default from has the form '{display_name} <{email_address}>'
      expect(ApplicationMailer.default[:from]).to include(mail.from.first)
    end

    it "renders the body" do
      expect(mail.body.encoded).to match(I18n.t("application_mailer.notification.hello", name: user.first_name))
    end

    it "finds name of user in email" do
      expect(mail.body.encoded).to match(user.name)
    end
  end

end
