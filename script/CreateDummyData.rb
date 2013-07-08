module CreateDummyData
  Dir["#{Rails.root}/app/models/*.rb"].each { |file| require file }
  ["Dev","Sales Rep", "Manager", "Admin"].each do |name|
    Role.create(name: name)
  end
  dev_role      = Role.find_by_name("Dev")
  sales_role    = Role.find_by_name("Sales Rep")
  manager_role  = Role.find_by_name("Manager")
  admin_role    = Role.find_by_name("Admin")
  
  ty = User.create(username: "tyjack", password: "fishcakes", name: "Tyrone Jackson", email: "tyrone.jackson@email.com")
  ty.roles << dev_role
  ty.roles << manager_role
  
  joe = User.create(username: "joe", password: "123456", name: "Joe Bob", email: "joe.bob@email.com")
  joe.roles << sales_role
  
  og = User.create(username: "ogarci5", password: "crabcakes", name: "Oliver Garcia", email: "ogarci5@gmail.com")
  og.roles << admin_role
  og.roles << dev_role
  
  cd = User.create(username: "chris", password: "654321", name: "Chris Ducharme", email: "chris.ducharme@rackspace.com")
  cd.roles << dev_role
  cd.roles << manager_role
  
  a = ApprovalGroup.create(name: "Real Estate")
  a.users << cd
   
  a = ApprovalGroup.create(name: "Finance")
  a.users << ty
  
  r = RequestGroup.create(name: "Dev 1")
  r.users << og
  r.users << joe
  
  r = RequestGroup.create(name: "Man 1")
  r.users << cd
  r.users << ty
end
