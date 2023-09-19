require 'rails_helper'

include Helpers

describe "Beer" do
  let!(:brewery) { FactoryBot.create :brewery, name: "Koff" }

  it "when name is valid, can be added" do
    visit new_beer_path
    select('Koff', from: 'beer[brewery_id]')
    select('IPA', from: 'beer[style]')
    fill_in('beer[name]', with: 'Koffin ipa')

    expect{
      click_button "Create Beer"
    }.to change{Beer.count}.from(0).to(1)
  end

  it "with nonvalid name, can not be added" do
    visit new_beer_path
    select('Koff', from: 'beer[brewery_id]')
    select('IPA', from: 'beer[style]')
    fill_in('beer[name]', with: '')
    click_button "Create Beer"

    expect(Beer.count).to eq(0)
    expect(page).to have_content "Name can't be blank"
  end
end