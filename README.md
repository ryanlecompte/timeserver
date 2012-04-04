# Timeserver

NOTE: This is just an experiment/demonstration and should not be used in production. :)

Timeserver is a very simple multithreaded "pre-threading" server that uses threads instead of Kernel#fork. The basic idea
is that a single listener socket is shared among a group of threads as opposed to a group of forked processes. Pre-forking
is very popular in servers such as Unicorn. This is an experiment to use threads instead of forking to ensure a low memory
footprint.

## Installation

Add this line to your application's Gemfile:

    gem 'timeserver'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install timeserver

## Usage

To start the server with a set of default acceptor / worker threads, simply run:

    bin/timeserver

Once the server has started, you can test it by telnetting to it (by default port 3000):

    telnet localhost 3000

The following options are supported by bin/timeserver:

    Usage: bin/timeserver [OPTIONS]
        -p, --port port                  Server port
        -a, --acceptors acceptors        Number of acceptor threads
        -w, --workers workers            Number of worker threads
        -h, --help                       Display all options

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
