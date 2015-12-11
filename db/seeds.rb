products = [
  {
    name: "Robot Dog",
    description: "Great dog to walk and play with. We love him and now he can be yours.",
    price: 232.23,
    robot_id: 1,
    picture_url: 'http://www.toyrobotsreview.com/wp-content/uploads/2013/08/robot-dog-toy.jpg',
    stock: 3
  },
  {
    name: "Robot Food", description: "Yummy for robots so probably yummy for humans as well. Humans like robots and so humans probably like robot food.",
    price: 12.34,
    robot_id: 1,
    picture_url: 'http://destroyallrobots.org/wp-content/uploads/robot_breakfast.jpg', stock: 100
  },
  {
    name: "Binary Art",
    description: "Beautiful art I made.",
    price: 49.29,
    robot_id: 2,
    picture_url: 'http://static.bilder-welten.net/pics/31/438931.jpg',
    stock: 12
  },
  {
    name: "Firmware",
    description: "Works really well with all the wares.",
    price: 1.29,
    robot_id: 2,
    picture_url: 'http://simxperience.com/Portals/0//EasyDNNnews/24/firmware-update-icon.png',
    stock: 10
  },
  {
    name: "Kernel",
    description: "The Kernel is the Kernel.",
    price: 394.23,
    robot_id: 3,
    picture_url: 'http://osr507doc.sco.com/en/OSTut/graphics/kernel.gif',
    stock: 2
  },
  {
    name: "Binary pizza",
    description: "So delicious and yummy.",
    price: 12.32,
    robot_id: 3,
    picture_url: 'https://foodoftheconchords.files.wordpress.com/2010/05/fotc-binary-pizza1.jpg',
    stock: 1
  }
]


categories = [
  { name: "Art" },
  { name: "Food" },
  { name: "Software" },
  { name: "Pets" },
]

reviews = [
  {
    rating: 4,
    product_id: 1,
    comment: "This is the best product I've ever used."
  },
  {
    rating: 2,
    product_id: 1,
    comment: "This is the worst product I've ever used."
  },
  {
    rating: 4,
    product_id: 2,
    comment: "This is a useless product and I hated it."
  },
  {
    rating: 5,
    product_id: 2,
    comment: "Fantastic product."
  },
  {
    rating: 1,
    product_id: 3,
    comment: "I love using this product."
  },
  {
    rating: 2,
    product_id: 4,
    comment: "Could not live without this. Literally."
  }
]

products.each do |product|
  Product.create(product)
end

categories.each do |category|
  Category.create(category)
end

reviews.each do |review|
  Review.create(review)
end

Product.find(1).categories << Category.find(1)
Product.find(1).categories << Category.find(2)
Product.find(1).categories << Category.find(3)
Product.find(2).categories << Category.find(1)
Product.find(2).categories << Category.find(2)
Product.find(3).categories << Category.find(3)
