require 'rails_helper'

describe "Admin on the matches page" do
  before { login_as admin }

  let!(:admin) { create :user, admin: true}
  let!(:user1) { create :user }
  let!(:user2) { create :user }

  context "before matching" do
    it "Does not contain user names" do
      visit matches_path

      expect(page).not_to have_text(user1.name)
      expect(page).not_to have_text(user2.name)
    end
  end

  context "after matching" do
    let!(:match1) { create :match, users: [user1, user2] }

    it "contains all student names" do
      visit matches_path

      expect(page).to have_text("#{user1.name} & #{user2.name}")
    end
  end
end
