require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "has name, style and brewery set correctly" do
    brewery = Brewery.create id: 1, name: "Hartwall", year: 1700
    beer = FactoryBot.create :beer, name: "Kaski", brewery: brewery

    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it "has no style" do
    brewery = Brewery.create id: 1, name: "Hartwall", year: 1700
    beer = Beer.create name: "Kaski", brewery: brewery

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "has no name" do
    brewery = Brewery.create id: 1, name: "Hartwall", year: 1700
    beer = Beer.create brewery: brewery

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end
end
