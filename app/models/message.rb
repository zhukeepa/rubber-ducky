class Message
  include ActiveModel::Model

  attr_accessor :title, :timer
  attr_reader :emails

  validates :title, :timer, :emails, presence: true

  def emails=(emails)
    @emails = emails.split(',').map(&:strip)
  end
end
