require 'rails_helper'

RSpec.describe User, type: :model do
  describe "association with matches" do
   let!(:first) { create :user }
   let!(:second) { create :user }
   let!(:match) { create :match, users: [first, second] }

   it "has many matches" do
     expect(first.matches.first.users).to include(second)
     expect(second.matches.first.users).to include(first)
   end
 end

 describe "methods" do
   let!(:user1) { create :user }
   let!(:user2) { create :user }
   let!(:user3) { create :user }
   let!(:user4) { create :user }
   let!(:user5) { create :user }

   let!(:match1) { create :match, users: [user1, user2] }
   let!(:match2) { create :match, date: Date.yesterday, users: [user1, user3] }
   let!(:match3) { create :match, date: Date.yesterday - 1, users: [user1, user4] }
   let!(:match4) { create :match, date: Date.tomorrow, users: [user1, user5] }


   it "name returns the full name" do
     expect(user1.name).to eq("#{user1.first_name} #{user1.last_name}")
   end

   it "todays_match returns only todays match" do
     debugger
     expect(user1.todays_match).to eq(user2.name)

   end

   it "past_matches returns matches before today" do
     expect(user1.past_matches).to include(match2)
     expect(user1.past_matches).to include(match3)
     expect(user1.past_matches).not_to include(match1)
     expect(user1.past_matches).not_to include(match4)
   end

   it "will not receive a new match if a match exists for that day" do
     Match.generate(Date.today)
     expect(user1).to eq(user2)
   end
 end
end
