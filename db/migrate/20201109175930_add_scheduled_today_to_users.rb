class AddScheduledTodayToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :scheduled_today, :boolean
  end
end
