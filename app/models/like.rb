class Like < ApplicationRecord
  belongs_to :eco
  belongs_to :user
  validates_uniqueness_of :eco_id, scope: :user_id
end
