class AddFormLoadToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :form_load, :string
  end
end
