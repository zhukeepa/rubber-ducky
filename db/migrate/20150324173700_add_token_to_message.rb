class AddTokenToMessage < ActiveRecord::Migration
  def change
    add_reference :messages, :token, index: true
    add_foreign_key :messages, :tokens
  end
end
