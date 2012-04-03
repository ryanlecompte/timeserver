require 'spec_helper'

module Timeserver
  describe ThreadPool do
    let(:pool) { ThreadPool.new(10) }

    describe '#<<' do
      it 'processes items added to the thread pool' do
        work = [proc { |arg| arg.upcase! }, 'foo']
        pool << work
        sleep 1
        work.last.should == 'FOO'
      end
    end

    describe '#shutdown' do
      it 'shuts down the thread pool properly' do
        pool.shutdown
        sleep 1
        pool << [proc {}, 'foo']
        sleep 1
        pool.queue_size.should == 1
      end
    end
  end
end