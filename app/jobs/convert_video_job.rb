class ConvertVideoJob < ApplicationJob
  queue_as :default

  def perform(call_id)
    VideoConverter.new(call_id).convert!
  end
end