module Timeserver
  # Encapsulates a callable job.
  class Job
    def initialize(*args, &block)
      @args = args
      @block = block
    end

    def invoke
      @block.call(*@args)
    end
  end

  # Generic thread pool that services jobs.
  class ThreadPool
    def initialize(size)
      @queue = Queue.new
      @workers = Array.new(size) do
        Thread.new do
          while job = @queue.pop
            job.invoke
          end
        end
      end
    end

    def <<(job)
      @queue << job
    end

    def queue_size
      @queue.size
    end

    def shutdown
      num_workers.times { @queue << nil }
      @workers.each(&:join)
      self
    end

    def num_workers
      @workers.size
    end
  end
end