require 'rails_helper'

RSpec.describe User, type: :model do
  describe "association with matches" do
   let!(:user1) { create :user }
   let!(:user2) { create :user }
   let!(:match1) { create :match, users: [user1, user2] }

   it "has many matches" do
     expect(user1.matches.first.users).to include(user2)
     expect(user2.matches.first.users).to include(user1)
   end
 end

 describe "methods" do
   let(:user) { create :user }
   let(:user2) { create :user }
   let(:user3) { create :user }
   let(:user4) { create :user }
   let(:user5) { create :user }

   let!(:match1) { create :match, date: Date.today, users: [user, user2] }
   let!(:match2) { create :match, date: Date.yesterday, users: [user, user3] }
   let!(:match3) { create :match, date: Date.yesterday - 1, users: [user, user4] }
   let!(:match4) { create :match, date: Date.tomorrow, users: [user, user5] }


   it "name returns the full name" do
     expect(user.name).to eq("#{user.first_name} #{user.last_name}")
   end

   it "todays_match returns only todays match" do
     expect(user.todays_match).to eq(match1)

   end

   it "past_matches returns matches before today" do
     expect(user.past_matches).to include(match2)
     expect(user.past_matches).to include(match3)
     expect(user.past_matches).not_to include(match1)
     expect(user.past_matches).not_to include(match4)
   end

   it "will not receive a new match if a match exists for that day" do
     Match.generate(Date.today)
     expect(user.todays_match).to eq(match1)
   end
 end
end
