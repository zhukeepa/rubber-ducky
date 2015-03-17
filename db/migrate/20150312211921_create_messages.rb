class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :title
      t.string :body
      t.string :emails
      t.integer :time_limit
      t.boolean :sent, default: false

      t.timestamps null: false
    end
  end
end
