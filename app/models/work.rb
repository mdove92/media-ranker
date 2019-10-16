class Work < ApplicationRecord
  has_many :votes
  validates :title, presence: true

  def self.by_category(category)
    works_list = Work.where(category: category)
    sorted_works = works_list.sort_by(votes.length).reverse
  end
end
