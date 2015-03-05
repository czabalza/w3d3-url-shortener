class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.timestamps
      t.integer :user_id
      t.string :short_url
    end

    add_index(:visits, :user_id)
    add_index(:visits, :short_url)
  end
end
