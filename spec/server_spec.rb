require 'socket'
require 'spec_helper'

module Timeserver
  describe Server do
    it 'handles an incoming request' do
      server = Server.new
      runner = Thread.new { server.run }
      response = TCPSocket.open('localhost', 3000).read
      response.should.should =~ /^Current time/
      server.shutdown
      runner.join
    end
  end
end
