# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(
   email: 'sample@gmail.com',
   password: '000000',
   name: 'テスト太郎',
   admin: true
)

PhotoPostGenre.create!(name: "ロケーション")
PhotoPostGenre.create!(name: "料理")
PhotoPostGenre.create!(name: "ギア")

ConsultationGenre.create!(name: "キャンプ場")
ConsultationGenre.create!(name: "ギア")
ConsultationGenre.create!(name: "キャンプファッション")
ConsultationGenre.create!(name: "その他")