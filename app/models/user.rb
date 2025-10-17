# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  validates :avatar, blob: { content_type: ['image/jpeg', 'image/png', 'image/gif'] }
end
