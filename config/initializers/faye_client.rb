module Bayeux
  def self.client
    @client ||= begin
      Thread.new { EM.run } unless EM.reactor_running?
      Thread.pass until EM.reactor_running?
      Faye::Client.new('http://localhost:9292/faye')
    end
  end
end