Admin.create!(
  email: "admin@email.com",
  password: "password")

4.times do |n|
  User.create!(
    uname: "User#{n + 1}",
    email: "sample#{n + 1}@email.com",
    password: "password"
  )
end
  