class Task < ApplicationRecord
  validates :title, presence: true
  scope :completed, -> { where(completed: true) }
  scope :pending, -> { where(completed: false) }
  scope :ordered_by_title, -> { reorder(Arel.sql("CAST(regexp_replace(title, '\\D', '', 'g') AS INTEGER), title ASC")) }
end
