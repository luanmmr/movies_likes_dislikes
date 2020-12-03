class CreateDislikes < ActiveRecord::Migration[5.2]
  def change
    create_table :dislikes do |t|
      t.references :user, foreign_key: true
      t.integer :episode_id, null: false

      t.timestamps
    end
  end
end
