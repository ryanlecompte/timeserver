require 'socket'
require 'thread'
require 'optparse'

require_relative 'timeserver/cli'
require_relative 'timeserver/server'
require_relative 'timeserver/thread_pool'
require_relative 'timeserver/version'

module Timeserver
  def self.run(opts)
    Server.new(CLI.parse(opts)).run
  end
end
