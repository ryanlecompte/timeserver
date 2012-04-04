module Timeserver
  # Example of a "threaded preforking" server using multiple acceptor threads
  # and a pool of worker threads to service the actual requests. Note
  # that this is similar to a real preforking server that uses Kernel#fork
  # to service requests concurrently with a single listener socket. The only
  # difference is that instead of multiple forked processes, we use multiple
  # acceptor threads.
  class Server
    TIMEOUT = 5

    def initialize(opts = {})
      @port = opts.fetch(:port, 3000)
      @num_acceptors = opts.fetch(:num_acceptors, 10)
      @pool = ThreadPool.new(opts.fetch(:num_workers, 10))
      @running = false
      puts "Server launched: #{@num_acceptors} acceptors, #{@pool.num_workers} workers."
    end

    def run
      install_signal_handlers
      run_acceptors
    end

    def shutdown
      puts 'Shutting down ...'
      @running = false
      @pool.shutdown
      self
    end

    private

    def run_acceptors
      @running = true
      @socket = TCPServer.new(@port)
      @acceptors = Array.new(@num_acceptors) do
        Thread.new do
          while @running
            if IO.select([@socket], nil, nil, TIMEOUT)
              begin
                conn = @socket.accept_nonblock
                @pool << Job.new(conn) { |client| handle_client(client) }
              rescue IO::WaitReadable, Errno::EINTR
              rescue => ex
                puts "Error while accepting client: #{ex.message}"
              end
            end
          end
        end
      end

      @acceptors.each(&:join)
      close(@socket)
    end

    def install_signal_handlers
      [:INT, :TERM].each do |signal|
        trap(signal) do
          shutdown
        end
      end
    end

    def handle_client(conn)
      conn.puts("Current time: #{Time.now.to_s}")
    rescue => ex
      puts "Error while writing to client: #{ex.message}"
    ensure
      close(conn)
    end

    def close(socket)
      socket.close if socket
    rescue
      # best effort
    end
  end
end
