require "rails_helper"

RSpec.describe IvotedMailer, type: :mailer do
  describe "reminder" do
    let(:mail) { IvotedMailer.reminder(:user) }

    it "renders the headers" do
      user = User.last
      expect(mail.subject).to eq("Don't forget to vote")
      expect(mail.to).to eq(user.email)
      expect(mail.from).to eq(["ivoted.help@gmail.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Thank you for signing up with I-Voted.")
    end
  end

end
