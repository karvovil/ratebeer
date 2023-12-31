require 'rails_helper'

RSpec.describe User, type: :model do
  it "has the username set correctly" do
    user = User.new username: "Pekka"

    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
    user = User.create username: "Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with too short password" do
    user = User.create username: "Pate", password: "S1", password_confirmation: "S1"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is has no capital" do
    user = User.create username: "Pate", password: "asdf", password_confirmation: "asdf"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user) { FactoryBot.create(:user) }
  
    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end
  
    it "and with two ratings, has the correct average rating" do
      FactoryBot.create(:rating, score: 10, user: user)
      FactoryBot.create(:rating, score: 20, user: user)
  
      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end
  
  describe "favorite style" do
    let(:user){ FactoryBot.create(:user) }
    
    it "has method for determining the favorite style" do
      expect(user).to respond_to(:favorite_style)
    end
    
    it "without ratings does not have a favorite style" do
      expect(user.favorite_style).to eq(nil)
    end
    
    it "is the only rated if only one rating" do
      beer = FactoryBot.create(:beer)
      rating = FactoryBot.create(:rating, score: 20, beer: beer, user: user)
      
      expect(user.favorite_style).to eq(beer.style.name)
    end
    
    it "is the one with highest sum of ratings if several rated" do
      lager1 = create_beer_with_rating({ user: user }, 20 )
      lager2 = create_beer_with_rating({ user: user }, 25 )
      style2 = FactoryBot.create(:style, name: "thebest style")
      stout1 = create_beer_with_rating({ user: user, style: style2}, 23 )
      stout2 = create_beer_with_rating({ user: user, style: style2}, 24 )
      expect(user.favorite_style).to eq(stout1.style.name)
    end
  end
  
  describe "favorite beer" do
    let(:user){ FactoryBot.create(:user) }

    it "has method for determining the favorite beer" do
      expect(user).to respond_to(:favorite_beer)
    end

    it "without ratings does not have a favorite beer" do
      expect(user.favorite_beer).to eq(nil)
    end

    it "is the only rated if only one rating" do
      rating = FactoryBot.create(:rating, score: 20, user: user)

      expect(user.favorite_beer).to eq(rating.beer)
    end

    it "is the one with highest rating if several rated" do
      create_beers_with_many_ratings({ user: user }, 10, 20, 15, 7, 9)
      best = create_beer_with_rating({ user: user }, 25 )

      expect(user.favorite_beer).to eq(best)
    end
  end

  describe "favorite brewery" do
    let(:user){ FactoryBot.create(:user) }
    
    it "has method for determining the favorite brewery" do
      expect(user).to respond_to(:favorite_brewery)
    end
    
    it "without ratings does not have a favorite style" do
      expect(user.favorite_brewery).to eq(nil)
    end
    
    it "is the only rated if only one rating" do
      beer = FactoryBot.create(:beer)
      rating = FactoryBot.create(:rating, score: 20, beer: beer, user: user)
      
      expect(user.favorite_brewery).to eq(beer.brewery)
    end
    
    it "is the one with highest sum of ratings if several rated" do
      brwry1 = FactoryBot.create(:brewery, name: "Panimo x")
      brwry2 = FactoryBot.create(:brewery, name: "Y panimo")

      lager1 = create_beer_with_rating({ user: user, brewery: brwry1 }, 20 )
      lager2 = create_beer_with_rating({ user: user, brewery: brwry1 }, 25 )
      stout1 = create_beer_with_rating({ user: user, brewery: brwry2 }, 23 )
      stout2 = create_beer_with_rating({ user: user, brewery: brwry2 }, 24 )
      expect(user.favorite_brewery).to eq(stout1.brewery)
    end
  end
end # describe User

def create_beer_with_rating(object, score)
  if object[:brewery]
    beer = FactoryBot.create(:beer, brewery: object[:brewery])
  elsif object[:style]
    beer = FactoryBot.create(:beer, style: object[:style])
  else
    beer = FactoryBot.create(:beer)
  end
  FactoryBot.create(:rating, beer: beer, score: score, user: object[:user])
  beer
end

def create_beers_with_many_ratings(object, *scores)
  scores.each do |score|
    create_beer_with_rating(object, score)
  end
end