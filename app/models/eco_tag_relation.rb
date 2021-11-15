class EcoTagRelation < ApplicationRecord
  belongs_to :eco
  belongs_to :tag
end
