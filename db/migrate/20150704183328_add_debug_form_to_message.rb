class AddDebugFormToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :debug_form, :boolean
  end
end
