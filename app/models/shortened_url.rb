# == Schema Information
#
# Table name: shortened_urls
#
#  id           :integer          not null, primary key
#  long_url     :string
#  short_url    :string
#  submitter_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class ShortenedUrl < ActiveRecord::Base
  validates :short_url, :presence => true, :uniqueness => true
  validates :submitter_id, :presence => true
  validates :long_url, :presence => true, :uniqueness => true

  def self.random_code
    while true
      shortened = SecureRandom.urlsafe_base64
      return shortened unless ShortenedUrl.exists?(short_url: shortened)
    end
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!(:submitter_id => user.id, :long_url => long_url,
     :short_url => ShortenedUrl.random_code)
  end

  def num_clicks
    self.visits.count
  end

  def num_uniques
    self.visitors.count
  end

  def num_recent_uniques
    self.visits.where('visits.created_at > ?', 10.minutes.ago).distinct.count
  end

  belongs_to(
    :submitter,
    :class_name => 'User',
    :foreign_key => :submitter_id,
    :primary_key => :id
  )

  has_many(:visits,
    :class_name => 'Visit',
    :foreign_key => :short_url_id,
    :primary_key => :id
  )

  has_many(
    :visitors,
    -> { distinct },
    :through => :visits,
    :source => :user
  )
end
