# == Schema Information
#
# Table name: visits
#
#  id           :integer          not null, primary key
#  created_at   :datetime
#  updated_at   :datetime
#  user_id      :integer
#  short_url_id :integer
#

class Visit < ActiveRecord::Base
  validates :user_id, :presence => true
  validates :short_url_id, :presence => true

  def self.record_visit!(user, shortened_url)
    Visit.create!(:user_id => user.id, :short_url_id => shortened_url.id)
  end

  belongs_to(
    :user,
    :class_name => 'User',
    :foreign_key => :user_id,
    :primary_key => :id
  )

  belongs_to(
  :short_url,
  :class_name => 'ShortenedUrl',
  :foreign_key => :short_url_id,
  :primary_key => :id
  )
end
