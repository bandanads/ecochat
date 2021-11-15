class CreateEcos < ActiveRecord::Migration[6.1]
  def change
    create_table :ecos do |t|
      t.text :body
      t.string :image
      t.integer :user_id
      t.string :title
      t.timestamps
    end
  end
end
