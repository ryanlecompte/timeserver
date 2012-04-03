module Timeserver
  # Parses server command-line arguments.
  class CLI
    def self.parse(source)
      return {} if source.empty?

      options = {}
      parser = OptionParser.new do |opts|
        opts.banner = "Usage: bin/timeserver [OPTIONS]"

        opts.on('-p', '--port port', 'Server port') do |port|
          options[:port] = Integer(port)
        end

        opts.on('-a', '--acceptors acceptors', 'Number of acceptor threads') do |count|
          options[:num_acceptors] = Integer(count)
        end

        opts.on('-w', '--workers workers', 'Number of worker threads') do |count|
          options[:num_workers] = Integer(count)
        end

        opts.on('-h', '--help', 'Display all options') do
          puts opts
          exit
        end
      end

      parser.parse!
      options
    end
  end
end