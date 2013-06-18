module CreateUser
  Dir["#{Rails.root}/app/models/*.rb"].each { |file| require file }
  User.create(username: "tyjack", password: "fishcakes", name: "Tyrone Jackson", email: "tyrone.jackson@email.com")
  User.create(username: "joe", password: "123456", name: "Joe Bob", email: "joe.bob@email.com")
  User.create(username: "ogarci5", password: "crabcakes", name: "Oliver Garcia", email: "ogarci5@gmail.com")
end
