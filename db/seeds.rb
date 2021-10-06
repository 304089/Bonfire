# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(email: 'admin@gmail.com',password: '000000',name: '管理裕一郎',admin: true)#管理者
User.create!(email: 'user1@gmail.com',password: '000000',name: '田中一郎',admin: false)
User.create!(email: 'user2@gmail.com',password: '000000',name: '高橋二郎',admin: false)
User.create!(email: 'user3@gmail.com',password: '000000',name: '鈴木三子',admin: false)
User.create!(email: 'user4@gmail.com',password: '000000',name: '斉藤四郎',admin: false)
User.create!(email: 'user5@gmail.com',password: '000000',name: '後藤五月',admin: false)


