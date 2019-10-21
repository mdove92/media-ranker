class Work < ApplicationRecord
  has_many :votes
  validates :title, presence: true

  def self.spotlight
    spotlighted_work = Work.all.sort_by { |work| -work.votes.length }.first
  end

  def self.by_category(category, count = 0)
    works_list = Work.where(category: category)

    if (count > 0)
      return works_list.sort_by { |work| -work.votes.length }.slice(0..count - 1)
    else
      return works_list.sort_by { |work| -work.votes.length }
    end
  end
end
