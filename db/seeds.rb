#Add seed data here. Seed your database with 'rake db:seed'
brett = Connoisseur.create(username: "Brett", email: "example1@gmail.com", password: "3115")
rach = Connoisseur.create(username: "Rach", email: "example2@gmail.com", password: "1114")

Scotch.create(name: "Lagavulin 16 Scotch", rating: "5", price: "84.00", review: "A much sought-after 
	single malt with the massive peat-smoke that's typical of southern Islay — but also offering a dryness 
	that turns it into a truly interesting dram. Lagavulin is an intense, smoky-sweet single malt with seaweed 
	flavours and a huge finish, aged in oak casks for at least sixteen years.", connoisseurs_id: "1")
Scotch.create(name: "Laphroaig 10 Year Old", rating: "4.5", price: "55.00", review: "Awarded Best Single Malt in 
	the World in 2005 by Whisky Magazine, Original Cask Strength Laphroaig is bottled at natural distillery strength 
	with all the depth of genuine taste and texture normally associated with sampling whisky at source.In making Laphroaig, 
	malted barley is dried over a peat fire. The smoke from this peat, found only on Islay, gives Laphroaig its 
	particularly rich flavour.", connoisseurs_id: "2")
Scotch.create(name: "Ardbeg Uigeadail", rating: "4", price: "79.00", review: "Ardbeg Uigeadail is a special vatting that 
	marries Ardbeg's traditional deep, smoky notes with luscious, raisiny tones of old ex-Sherry casks. It's non chill-filtered 
	at high strength, which retains maximum flavor and gives more body and added depth.", connoisseurs_id: "1")
Scotch.create(name: "Glenlivet 18 Year Old Single Malt Scotch Whisky", rating: "3.5", price: "85.00", review: "The Glenlivet 18 
	Year Old is the perfect expression of age and elegance, balancing the archetypal ripe fruit notes of The Glenlivet with a 
	drier evocative oak influence. The perfect after-dinner dram.", connoisseurs_id: "2")