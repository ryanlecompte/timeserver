require 'socket'
require 'thread'
require 'optparse'

require 'timeserver/cli'
require 'timeserver/server'
require 'timeserver/thread_pool'
require 'timeserver/version'

module Timeserver
  def self.run(opts)
    Server.new(CLI.parse(opts)).run
  end
end
