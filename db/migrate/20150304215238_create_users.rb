class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.timestamps
      t.string :email
    end

    add_index(:users, :email, :unique => true)
  end
end
