class Challenge < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3, maximum: 255 }
  validates :description, presence: true, length: { minimum: 100 }
  validates :start_date, presence: true, inclusion: { in: ->(_) { Date.today..(Date.today + 1.year) } }
  validates :end_date, presence: true, comparison: { greater_than: :start_date }
end
