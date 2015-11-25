require "rails_helper"

RSpec.describe IvotedMailer, type: :mailer do
  describe "reminder" do
    let(:user) {User.create(email: "cat@cat.com", password: "password", street_address: "4432 N. Seeley, Chicago, Illinois",zip: "67025")}
    let(:mail) { IvotedMailer.reminder(user) }

    it "renders the headers" do
      user = User.last
      expect(mail.subject).to eq("Dont forget to vote")
    end

    it "renders the body" do
      expect(mail.body.should include("Thank you for signing up with I-Voted."))
    end
  end

end
