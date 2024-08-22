# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create(email: '1@1', password: '123456')

# Customer.create(first_name: '佐藤', last_name: '太郎', first_name_kana: 'サトウ', last_name_kana: 'タロウ', address: '東京都世田谷区', phone: '12345678901', post_code: '123467', email: '1@234', password: '123456', is_active: 'true')

Customer.find_or_create_by!(first_name: '佐藤') do |customer|
    customer.last_name = '太郎'
    customer.first_name_kana = 'サトウ'
    customer.last_name_kana = 'タロウ'
    customer.address = '東京都世田谷区'
    customer.phone = '12345678901'
    customer.post_code = '1234567'
    customer.email = '1@234.com'
    customer.password = '123456'
    customer.is_active = 'true'
end

Category.create(name: 'ケーキ')
Category.create(name: '焼き菓子')
Category.create(name: 'プリン')
Category.create(name: 'キャンディ')

Item.find_or_create_by!(name: 'チョコレートケーキ') do |item|
    item.description = 'ベルギー産のチョコレートを使用しています'
    item.category_id = 1
    item.price = 1000
    item.is_active = 'true'
    item.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/cake1.jpg"), filename:"cake1.jpg")
end

Item.find_or_create_by!(name: 'キャンディ') do |item|
    item.description = 'キャンディです'
    item.category_id = 4
    item.price = 100
    item.is_active = 'true'
    item.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/candie1.jpg"), filename:"candie1.jpg")
end