class Tag < ApplicationRecord
    has_many :eco_tag_relations, dependent: :destroy
    has_many :ecos, through: :eco_tag_relations, dependent: :destroy
end
