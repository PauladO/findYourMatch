require 'rails_helper'

describe "users/show.html.erb" do
  before { login_as user }

  let(:user) { create :user }
  let(:user2) { create :user }
  let(:user3) { create :user }
  let(:user4) { create :user }
  let(:user5) { create :user }

  let!(:match1) { create :match, date: Date.today, users: [user, user2] }
  let!(:match2) { create :match, date: Date.yesterday, users: [user, user3] }
  let!(:match3) { create :match, date: Date.yesterday - 1, users: [user, user4] }
  let!(:match4) { create :match, date: Date.tomorrow, users: [user, user5] }



  it "shows todays match" do
    visit matches_path
    expect(page).to have_text("Todays match: #{user2.name}")
  end

  it "shows past matches" do
    visit matches_path

    expect(page).to have_text(user3.name)
    expect(page).to have_text(user4.name)
  end

  it "doesn't show future matches" do
    visit matches_path

    expect(page).not_to have_text(user5.name)
  end
end
