class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :description
      t.text :picture
      t.text :answer
      t.text :comments
      t.boolean :flag
      t.text :tags

      t.timestamps null: false
    end
  end
end
