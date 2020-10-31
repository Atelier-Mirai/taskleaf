# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

family_names = %w(朝日 加藤 佐々木 田中 中村 橋本 松下 八木 乱橋 渡辺)
given_names  = %w(愛子 佳代子 小夜子 妙 奈美 春美 まゆみ 八重子 蘭子 和歌子)
romaji_names = %w(asahi kato sasaki tanaka nakamura hashimoto matsumoto yagi rambashi watanabe)

10.times do |i|
  User.find_or_create_by!(email: "#{romaji_names[i]}@example.com") do |user|
    user.name            = "#{family_names[i]} #{given_names[i]}"
    user.password_digest = BCrypt::Password.create('password', cost: BCrypt::Engine::MIN_COST)
    user.admin           = false
  end
end

admin = User.find_or_create_by!(email: "admin@example.com") do |user|
          user.name            = "admin"
          user.password_digest = BCrypt::Password.create('password', cost: BCrypt::Engine::MIN_COST)
          user.admin           = true
        end

words = %w(あの イーハトーヴォ の すきとおった 風 夏 でも 底 に 冷たさ を もつ 青いそら うつくしい 森 で 飾られた モリーオ市 郊外の ぎらぎら ひかる 草の波 また そのなかで いっしょ なった たくさんの ひとたち ファゼーロ ロザーロ 羊飼の ミーロや 顔の赤いこどもたち 地主のテーモ 山猫博士の ボーガント・デストゥパーゴなど いまこの暗い巨きな石の建物のなかで考え いる みんな むかし 風のなつかしい青い幻燈のよう 思われます わたくし いつかの小さなみだし つけながら しずか あの年の イーハトーヴォの 五月から 十月まで 書きつけましょう)

10.times do |i|
  description = <<~EOS
                 #{words.shuffle[0..3].join}
                 #{words.shuffle[0..7].join}
                 #{words.shuffle[0..5].join}
                EOS
  Task.create!(name: "管理者タスク #{i}",
               description: description,
               user_id: admin.id)
end
