# frozen_string_literal: true

class Report < ApplicationRecord
  TARGET_URI = %r{http://localhost:3000/reports/(\d+)}

  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :mentions, foreign_key: :mentioned_report_id, dependent: :destroy, inverse_of: :mentioned_report
  has_many :mentioning_reports, -> { distinct }, through: :mentions

  has_many :received_mentions, class_name: 'Mention', foreign_key: :mentioning_report_id, dependent: :destroy, inverse_of: :mentioning_report
  has_many :mentioned_reports, -> { distinct }, through: :received_mentions

  validates :title, presence: true
  validates :content, presence: true

  def editable?(target_user)
    user == target_user
  end

  def created_on
    created_at.to_date
  end

  def create_mentions
    mentioning_ids = content.scan(TARGET_URI).flatten.uniq
    mentioning_ids.each do |mentioning_id|
      next if mentioning_id.to_i == id

      mentions.create!(mentioning_report_id: mentioning_id) if Report.exists?(mentioning_id)
    end
  end

  def update_mentions
    mentions.destroy_all
    create_mentions
  end
end
