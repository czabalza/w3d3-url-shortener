class CreateTagTopics < ActiveRecord::Migration
  def change
    create_table :tag_topics do |t|
      t.string :topic
      t.timestamps
    end

    create_table :taggings do |t|
      t.integer :url_id
      t.integer :topic_id
      t.timestamps
    end

    add_index(:taggings, :url_id)
    add_index(:taggings, :topic_id)
  end
end
