class Message
  include ActiveModel::Model

  attr_accessor :title
  attr_reader :emails, :timer

  validates :title, :timer, :emails, presence: true

  def emails=(emails)
    @emails = emails.split(',').map(&:strip)
  end

  def timer=(timer)
    @timer = timer.to_i*60
  end
end
