Admin.create!(
  email: "admin@email.com",
  password: "password")

# Admin.find_or_create_by(id: 1) do |admin|
#   admin.email = "admin@email.com"
#   admin.password: "password"
# end

User.create!(
  uname: "User1",
  email: "sample1@email.com",
  password: "password"
)
  