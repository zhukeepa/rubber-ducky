class FixTimerName < ActiveRecord::Migration
  def change
    rename_column :messages, :timer, :time_limit
  end
end
