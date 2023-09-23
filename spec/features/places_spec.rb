require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name: "Oljenkorsi", id: 1 ) ]
    )
    allow(WeatherstackApi).to receive(:get_weather_in).with("kumpula").and_return(
      {"temperature"=>17, "weather_icons"=>["https://cdn.worldweatheronline.com/images/wsymbols01_png_64/wsymbol_0002_sunny_intervals.png"], "wind_speed"=>13, "wind_dir"=>"SSW"}
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if many are returned by the API, they are shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name: "Oljenkorsi", id: 1 ),
        Place.new( name: "Kapakka", id: 2 ) ]
    )
    allow(WeatherstackApi).to receive(:get_weather_in).with("kumpula").and_return(
      {"temperature"=>17, "weather_icons"=>["https://cdn.worldweatheronline.com/images/wsymbols01_png_64/wsymbol_0002_sunny_intervals.png"], "wind_speed"=>13, "wind_dir"=>"SSW"}
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"
    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Kapakka"
  end

  it "If no places are found in location 'No locations in city" do
    allow(BeermappingApi).to receive(:places_in).with("kampila").and_return([])
    allow(WeatherstackApi).to receive(:get_weather_in).with("kampila").and_return(
      {}
    )
    visit places_path
    fill_in('city', with: 'kampila')
    click_button "Search"
    expect(page).to have_content "No locations in kampila"
  end
end