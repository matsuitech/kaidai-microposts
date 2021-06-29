class Micropost < ApplicationRecord
  belongs_to :user
  has_many :hashtag_relations
  has_many :hashtags, through: :hashtag_relations
  
  validates :content, presence: true, length: { maximum: 255 }
  
  #DBへのコミット直前に実施する
  after_create do
    micropost = Micropost.find_by(id: self.id)
    hashtags = self.content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    micropost.hashtags = []
    hashtags.uniq.map do |hashtag|
      #ハッシュタグは先頭の'#'を外した上で保存
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      micropost.hashtags << tag
    end
  end
  
  before_update do
    micropost = Micropost.find_by(id: self.id)
    micropost.hashtags.clear
    hashtags = self.content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      microposts << tag
    end
  end

end
