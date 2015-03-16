class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :title
      t.string :body
      t.string :emails
      t.integer :timer

      t.timestamps null: false
    end
  end
end
