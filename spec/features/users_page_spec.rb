require 'rails_helper'

include Helpers

describe "User" do
  let!(:user) { FactoryBot.create :user }

  describe "who has signed up" do
    it "can signin with right credentials" do
      visit signin_path
      sign_in(username: "Pekka", password: "Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to signin form if wrong credentials given" do
      visit signin_path
      sign_in(username: "Pekka", password: "Barfoo3")
      
      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end

    it "when signed up with good credentials, is added to the system" do
      visit signup_path
      fill_in('user_username', with: 'Brian')
      fill_in('user_password', with: 'Secret55')
      fill_in('user_password_confirmation', with: 'Secret55')
    
      expect{
        click_button('Create User')
      }.to change{User.count}.by(1)
    end
  end

  describe "who has ratings and is signed in" do
    before :each do
      FactoryBot.create(:rating, score: 10, user: User.first)
      FactoryBot.create(:rating, score: 20, user: User.first)
      visit signin_path
      sign_in(username: "Pekka", password: "Foobar1")
    end
    
    it "can see his ratings on his page, but no others ratings" do
      user2 =  FactoryBot.create(:user, username: 'Make') 
      FactoryBot.create(:rating, score: 17, user: user2)
      visit user_path(user.id)

      expect(page).to have_content 'anonymous 10'
      expect(page).to have_content 'anonymous 20'
      expect(Rating.count).to eq(3)
      expect(page).to_not have_content '17'
    end
# TODO accept confirm dialogue
#    it "can remove his rating" do
#      visit user_path(user.id)
#      find(:xpath, "(//input[@name='ratings[]'])[1]").click
#      accept_confirm do
#        find(:xpath, "(//button[text()='Delete selected'])").click
#      end
#      expect(Rating.count).to eq(1)
#      expect(page).to_not have_content 'anonymous 10'
#    end

    it "can see favorite beer and brewery" do
      visit user_path(user.id)
      expect(page).to have_content 'Favorite beer: anonymous'
      expect(page).to have_content 'Favorite brewery: anonymous'
    end
  end
end