# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name: "田中 浩二",
    kana: "たなかこうじ",
    amount: 300
)

User.create!(name: "松田 慎吾",
    kana: "まつだしんご",
    amount: 300
)
    
User.create!(name: "斎藤 花子",
    kana: "さいとうはなこ",
    amount: 400
)

User.create!(name: "高橋 洋子",
    kana: "たかはしようこ",
    amount: 250
)

User.create!(name: "北村 庄司",
    kana: "きたむらしょうじ",
    amount: 0
)

LoginUser.create!(
    name: "adminUser",
    login_id: "crisi/admin",
    password: "crisi",
    admin: true
)


LoginUser.create!(
    name: "guestUser",
    login_id: "crisi",
    password: "crisi",
    admin: false
)