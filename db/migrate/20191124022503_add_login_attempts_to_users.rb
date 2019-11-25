class AddLoginAttemptsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :login_attempts, :integer, :default => 0
  end
end
