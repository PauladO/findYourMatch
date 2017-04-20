require 'rails_helper'

describe "shared/_navbar.html.erb" do
  before { sign_in user }

  context "student" do
    let(:user) { create :user }

    it "renders links to matches" do
      render
      expect(rendered).to have_content("My matches")
    end
  end

  context "admin" do
    let(:user) { create :user, admin: true }

    it "renders links to all users" do
      render
      expect(rendered).to have_content("all users")
    end

    it "renders links to all matches" do
      render
      expect(rendered).to have_content("all matches")
    end
  end

end
