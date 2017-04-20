
require 'rails_helper'

describe "Admin view of user list" do
  before { login_as user }

  let(:user) { create :user, admin: true}
  let!(:another_user) { create :user }

  it "shows all user names on index" do
    visit users_path
    expect(page).to have_text(user.name)
    expect(page).to have_text(another_user.name)
  end

end
