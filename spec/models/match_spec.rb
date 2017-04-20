require 'rails_helper'

RSpec.describe Match, type: :model do
  describe "association with users" do
   let!(:user1) { create :user }
   let!(:user2) { create :user }
   let!(:match1) { create :match, users: [user1, user2] }

   it "has many users" do
     expect(match1.users).to include(user1)
     expect(match1.users).to include(user2)
   end
 end

 describe "method generate creates new matches" do
   let!(:user) { create :user }
   let!(:user2) { create :user }
   let!(:user3) { create :user }
   let!(:user4) { create :user }
   let!(:user5) { create :user }

   it "assigns each user to a match" do
     Match.generate
     expect(Match.all.length).to eq(3)
   end
 end
end
