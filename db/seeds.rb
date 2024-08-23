
Admin.create(email: '1@1', password: '123456')


Customer.find_or_create_by!(first_name: '太郎') do |customer|
    customer.last_name = '佐藤'
    customer.first_name_kana = 'タロウ'
    customer.last_name_kana = 'サトウ'
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

Item.find_or_create_by!(name: 'アメリカンクッキー') do |item|
    item.description = 'チョコレートとバニラ一枚ずつのセットです'
    item.category_id = 2
    item.price = 400
    item.is_active = 'true'
    item.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/cookie1.jpg"), filename:"cookie1.jpg")
end

Item.find_or_create_by!(name: 'カスタードプリン') do |item|
    item.description = 'なめらかで優しい甘さのプリンです'
    item.category_id = 3
    item.price = 400
    item.is_active = 'true'
    item.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/pudding1.jpg"), filename:"pudding1.jpg")
end

Item.find_or_create_by!(name: 'キャンディ') do |item|
    item.description = 'ガラスの容器にいれてお届けします'
    item.category_id = 4
    item.price = 800
    item.is_active = 'true'
    item.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/candie1.jpg"), filename:"candie1.jpg")
end

Item.find_or_create_by!(name: 'ラズベリーのレアチーズ') do |item|
    item.description = '甘酸っぱいラズベリーのさわやかなレアチーズケーキです'
    item.category_id = 1
    item.price = 900
    item.is_active = 'true'
    item.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/cake2.jpg"), filename:"cake2.jpg")
end

Item.find_or_create_by!(name: '和栗のロールケーキ') do |item|
    item.description = '和栗を贅沢に使用したロールケーキです'
    item.category_id = 1
    item.price = 800
    item.is_active = 'true'
    item.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/cake3.jpg"), filename:"cake3.jpg")
end

Item.find_or_create_by!(name: '生チョコカップケーキ') do |item|
    item.description = '大きな生チョコを乗せたカップケーキです'
    item.category_id = 1
    item.price = 800
    item.is_active = 'true'
    item.image = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/cake4.jpg"), filename:"cake4.jpg")
end