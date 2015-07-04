class AddDebugToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :debug, :boolean
  end
end
