class CreateHashtagRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :hashtag_relations do |t|
      t.references :micropost, null: false, foreign_key: true
      t.references :hashtag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
