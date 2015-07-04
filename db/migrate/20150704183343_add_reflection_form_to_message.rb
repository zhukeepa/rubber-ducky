class AddReflectionFormToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :reflection_form, :boolean
  end
end
