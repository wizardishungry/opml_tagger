require 'optparse'
require 'optparse/time'
require 'ostruct'

module OpmlTagger
  class OptionParser < OptionParser
    def self.parse(args)
      options = OpenStruct.new
      options.host = 'pinboard.in'
      options.verbose = false
      
      opts = self.new do |opts|
        opts.banner = "Usage: #{$0} [options]"

        opts.separator ''
        opts.separator 'Specific options:'
        
        opts.on("-u", "--url [HOST]",
          "API host or url, default: #{options.host}",
          "  if API host is not a full url, the url will take the form",
          '  http://api.HOST/') do |host|
          options.host = host
        end

        # Boolean switch.
        opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
          options.verbose = v
        end

        # No argument, shows at tail.  This will print an options summary.
        opts.on_tail("-h", "--help", "Show this message") do
          puts opts
          exit
        end

        # Another typical switch to print the version.
        opts.on_tail("--version", "Show version") do
          puts OptionParser::Version.join('.')
          exit
        end
      end

      opts.parse!(args)
      options

    end
  end
end
