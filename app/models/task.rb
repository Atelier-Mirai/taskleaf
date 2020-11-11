class Task < ApplicationRecord
  # has_one_attached :image # 添付画像は一つ
  has_many_attached :images # 複数の添付画像

  # activestorage-validator による添付画像の検証
  validates :images,
    content_type: %i(gif png jpg jpeg),                        # 画像の種類
    size: { less_than_or_equal_to: 5.megabytes },              # ファイルサイズ
    dimension: { width: { max: 2000 }, height: { max: 2000 } } # 画像の大きさ

  # before_validation :set_nameless_name

  validates :name, presence: true
  validates :name, length: { maximum: 30 }
  validate :validate_name_not_including_comma

  belongs_to :user

  scope :recent, -> { order(created_at: :desc) }

  class << self
    # モデル側で検索対象のカラムを指定する。
    # (Strong Parametersのメンテナンスが大変なため)
    def ransackable_attributes(auth_object = nil)
      %w[name created_at]
    end

    def ransackable_associations(auth_object = nil)
      []
    end

    def csv_attributes
      %w(name description created_at updated_at)
    end

    def generate_csv
      CSV.generate(headers: true) do |csv|
        csv << csv_attributes
        all.each do |task|
          csv << csv_attributes.map{ |attr| task.send(attr) }
        end
      end
    end

    def import(file)
      CSV.foreach(file.path, headers: true) do |row|
        task = new # Task.new と ほぼ同意
        task.attributes = row.to_hash.slice(*csv_attributes)
        task.save!
      end
    end
  end

  private

  # def set_nameless_name
  #   self.name = '名前無し' if name.blank?
  # end

  def validate_name_not_including_comma
    errors.add(:name, 'にカンマを含めないでください') if name&.include?(',')
  end
end
