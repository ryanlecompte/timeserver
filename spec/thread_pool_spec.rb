require 'spec_helper'

module Timeserver
  describe ThreadPool do
    let(:pool) { ThreadPool.new(10) }

    describe '#<<' do
      it 'processes items added to the thread pool' do
        s = 'foo'
        job = Job.new(s) { |arg| arg.upcase! }
        pool << job
        sleep 1
        s.should == 'FOO'
      end
    end

    describe '#shutdown' do
      it 'shuts down the thread pool properly' do
        pool.shutdown
        sleep 1
        pool << Job.new {}
        sleep 1
        pool.queue_size.should == 1
      end
    end
  end
end