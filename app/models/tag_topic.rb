# == Schema Information
#
# Table name: tag_topics
#
#  id         :integer          not null, primary key
#  topic      :string
#  created_at :datetime
#  updated_at :datetime
#

class TagTopic < ActiveRecord::Base
  validates :topic, :presence => true, :uniqueness => true

  has_many(
    :taggings,
    :class_name => 'Tagging',
    :foreign_key => :topic_id,
    :primary_key => :id
  )

  has_many(
    :urls,
    :through => :taggings,
    :source => :url
  )

end
