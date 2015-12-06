class AddFromToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :from, :string
  end
end
