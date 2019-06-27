class CreateTours < ActiveRecord::Migration[5.2]
  def change
    create_table :tours do |t|
      t.string :name
      t.string :description
      t.string :image
      t.boolean :enable, default: true
      t.timestamps
      t.references :user, index: true, foreign_key: { to_table: :users }
      t.references :category, index: true, foreign_key: { to_table: :categories }
    end
  end
end
