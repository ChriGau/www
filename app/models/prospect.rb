# == Schema Information
#
# Table name: prospects
#
#  id         :integer          not null, primary key
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Prospect < ApplicationRecord
  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
    message: "not an email" }
  after_create :notify_slack

  private

  def notify_slack
    NotifySlack.perform_later({
      "channel": Rails.env.development? ? "test" : "incoming",
      "username": "www",
      "icon_url": "https://raw.githubusercontent.com/lewagon/mooc-images/master/slack_bot.png",
      "text": "New prospect on /learn: #{email}"
    })
  end
end
