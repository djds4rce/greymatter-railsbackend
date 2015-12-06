class AddFbIdToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :fbid, :string
  end
end
