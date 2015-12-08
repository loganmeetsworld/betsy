# Product model 

products = [
  { name: "Robot Dog", price: 232.23, robot_id: 1, picture_url: 'http://www.toyrobotsreview.com/wp-content/uploads/2013/08/robot-dog-toy.jpg', stock: 3
  },
  { name: "Robot Food", price: 12.34, robot_id: 1, picture_url: 'http://destroyallrobots.org/wp-content/uploads/robot_breakfast.jpg', stock: 100
  },
  { name: "Binary Art", price: 49.29, robot_id: 2, picture_url: 'http://static.bilder-welten.net/pics/31/438931.jpg', stock: 12
  },
  { name: "Firmware", price: 1.29, robot_id: 2, picture_url: 'http://simxperience.com/Portals/0//EasyDNNnews/24/firmware-update-icon.png', stock: 10
  },
  { name: "Kernel", price: 394.23, robot_id: 3, picture_url: 'http://osr507doc.sco.com/en/OSTut/graphics/kernel.gif', stock: 2
  },
  { name: "Binary pizza", price: 12.32, robot_id: 3, picture_url: 'https://foodoftheconchords.files.wordpress.com/2010/05/fotc-binary-pizza1.jpg', stock: 1
  }
]

products.each do |product|
  Product.create(product)
end