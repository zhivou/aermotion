class Blog < ApplicationRecord

  has_one_attached :main_image
  has_rich_text :body_area
  validates_presence_of :title, :body_area

  def self.simple_search(phrase)
    if phrase
      where("title LIKE ?", "%#{phrase}%")
          .or(where("title LIKE ?", "%#{phrase.capitalize}%"))
    else
      all
    end
  end
end
