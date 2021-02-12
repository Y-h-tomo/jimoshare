class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to :user
  has_one_attached :image
  has_many :tickets
  has_many :likes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  NGWORD = %w[
    広告 チラシ オークション クリック SEO自動 自動相互 会員募集 友達紹介 サイト比較 携帯サイト アフィリエイト テレウェイヴ マイミク 印刷 マーチャント 稼げ 稼ぐ 稼い 儲か 儲け クレジットカード サクラ 無料 激安 格安 キャッシ 現金 収入 謝礼 商材 裏ワザ 提携 在宅 副業 情報商材 月収 万円 アルバイト 副収入 日給 QUOカード 即金 おまとめローン 消費者金融 サラ金 多重債務 破産 為替 証拠金 回収 家電 ブランド アクセサリ 限定 オメガ OMEGA ロレックス ROLEX rolex クルーザー シューズ メンズ ファッション 通販 人気ランキング ハッピーライフ サンプル グッズ 娯楽 笑い 野球 サッカー アニメ キャンセラー サンプル動画 テクノストレス 出版 プレゼン 福袋 ホットな ハッピーメール ドラマ 焼肉 馬 牛 鶏 ホルモン 惣菜 英会話 語学 受験 合格 宮古島 ダイエット 健康 健康器具 美容 サプリ スリム エクササイズ ギフト カタログ 効く 脱毛 コスメ 便秘 エイズ 感染 鳥インフル ビューティ クリニック 矯正 整体 マッサージ 花粉 驚異 毛髪 精力 便秘 オリゴ 歯科 腋臭 わきが 性病 治療 ギャンブル カジノ パチスロ パチンコ 宝くじ 換金 高額 合法 小遣 キャッシュバック 競馬 大金 億万長者 換金 Casino ポーカー スピリチュアル 金運 開運 風水 財布 霊感 祭 占い 仏教 開運 幸運 宇宙 高天原 アダルト 美人 素人 女子 熟女 少女 子大 子校 彼氏 愛人 モデル 女優 俳優 アイドル 芸能 セフレ 童貞 処女 出会 援助 交際 逆援 待ち合 デート セックス SEX sex ＳＥＸ 性交 本番 ファック 中出し 性器 まんこ MANKO manko マンコ チンポ 肉棒 爆乳 巨乳 オッパイ アナル アヌス オナニー 指マン フェラ イラマチオ 顔射 ぶっかけ 射精 精液 愛液 マゾ サド バイブ ボンデージ ホモ レズ 変態 性癖 性感 無理やり うひゃうひゃ 満喫 スタービーチ 家出 着エロ ホスト 過激 無修正 エロ動画 ローション グラフィック 訳あり 露出 乱交 スワッピング エッチ 包茎 手淫 オナニー えっち ナンパ 友達紹介 のぞき スカート パンツ パンティ 下着 ハプニング 無料動画 サンプル動画 グラビア 接写 盗撮 見放題 ポルノ 官能 エロい エロティック エロス ヌード ラブホ デリヘル ホテヘル 風俗 喘ぎ 淫 裸 覗 舐 咥 濡 姦 淫 汁 膣 辱 痴 猥
  ].freeze
  NGWORD_REGEX = /...../.freeze

  with_options presence: true do
    validates :name, length: { maximum: 40 }, exclusion: { in: NGWORD, message: 'にNGワードが含まれています' },
                     format: { without: NGWORD_REGEX, message: 'は5文字以上の繰り返しは禁止です' }
    validates :quantity, numericality: { greater_than: -1, less_than: 100 }
    validates :description, length: { maximum: 200 }, exclusion: { in: NGWORD, message: 'にNGワードが含まれています' },
                            format: { without: NGWORD_REGEX, message: 'は5文字以上の繰り返しは禁止です' }
    validates :deadline
    validates :price, format: { with: /\A[0-9]+\z/ }, numericality: { less_than: 1_000_000 }
    validates :contact_location, exclusion: { in: NGWORD, message: 'にNGワードが含まれています' },
                                 format: { without: NGWORD_REGEX, message: 'は5文字以上の繰り返しは禁止です' }
    validates :image
  end
  with_options numericality: { other_than: 1 } do
    validates :prefecture_id
    validates :category_id
    validates :condition_id
  end

  validate :date_before_start
  def date_before_start
    return if deadline.blank?

    errors.add(:deadline, 'は今日以降のものを選択してください') if deadline < Date.today
  end

  def favorites_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def likes_by?(user)
    likes.where(user_id: user.id).exists?
  end
  ransacker :likes_count do
    query = '(SELECT COUNT(likes.item_id) FROM likes where likes.item_id = items.id GROUP BY likes.item_id)'
    Arel.sql(query)
  end
end
