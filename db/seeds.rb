# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Brewery.destroy_all
Style.destroy_all
User.destroy_all

b1 = Brewery.create name: 'Koff', year: 1897
b2 = Brewery.create name: 'Malmgard', year: 2001
b3 = Brewery.create name: 'Weihenstephaner', year: 1040

d1 = "Lager (/ˈlɑːɡər/) is a type of beer which has been brewed and conditioned at low temperature. Lagers can be pale, amber, or dark. Pale lager is the most widely consumed and commercially available style of beer. The term `lager` comes from the German for `storage`, as the beer was stored before drinking, traditionally in the same cool caves in which it was fermented."
d2 = "Pale ale is a golden to amber coloured beer style brewed with pale malt. The term first appeared in England around 1703 for beers made from malts dried with high-carbon coke, which resulted in a lighter colour than other beers popular at that time. Different brewing practices and hop quantities have resulted in a range of tastes and strengths within the pale ale family"
d3 = "Porter is a style of beer that was developed in London, England in the early 18th century. It was well-hopped and dark in appearance owing to the use of brown malt. The name is believed to have originated from its popularity with porters."
d4 = "Weizenbier or Hefeweizen, in the southern parts of Bavaria usually called Weißbier (literally `white beer`, referring to the pale air-dried malt, as opposed to `brown beer` made from dark malt dried over a hot kiln), is a beer, traditionally from Bavaria, in which a significant proportion of malted barley is replaced with malted wheat."

s1 = Style.create name: 'Lager', description: d1
s2 = Style.create name: 'Pale Ale', description: d2
s3 = Style.create name: 'Porter', description: d3
s4 = Style.create name: 'Weizen', description: d4

p1 = b1.beers.create name: 'Iso 3', style_id: s1.id
p2 = b1.beers.create name: 'Karhu', style_id: s1.id
p3 = b1.beers.create name: 'Tuplahumala', style_id: s1.id
p4 = b2.beers.create name: 'Huvila Pale Ale', style_id: s2.id
p5 = b2.beers.create name: 'X Porter', style_id: s3.id
p6 = b3.beers.create name: 'Hefeweizen', style_id: s4.id
p7 = b3.beers.create name: 'Helles', style_id: s1.id
