Admin.create!(
  email: "admin@email.com",
  password: "password")

# Admin.find_or_create_by(id: 1) do |admin|
#   admin.email = "admin@email.com"
#   admin.password: "password"
# end

4.times do |n|
  User.create!(
    uname: "User#{n + 1}",
    email: "sample#{n + 1}@email.com",
    password: "password"
  )
end
  