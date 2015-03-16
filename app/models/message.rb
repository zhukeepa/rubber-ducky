class Message < ActiveRecord::Base
  validates :title, :time_limit, :emails, presence: true

  def time_limit=(time_limit)
    write_attribute('time_limit', time_limit.to_i*60)
    # self.time_limit = time_limit.to_i*60
  end
end
