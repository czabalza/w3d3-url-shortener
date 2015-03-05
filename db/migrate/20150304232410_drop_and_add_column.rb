class DropAndAddColumn < ActiveRecord::Migration
  def change
    remove_column :visits, :short_url
    add_column :visits, :short_url_id, :integer
    add_index(:visits, :short_url_id)
  end
end
