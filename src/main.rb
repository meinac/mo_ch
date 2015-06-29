require 'active_support/all'
require 'active_record'
require 'roo'
require 'optparse'
require 'pry'

#INIT OPTIONS
options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: ruby src/main.rb [options]"

  opts.on("-p PATH", "--path PATH", "Path of the csv file") do |p|
    options[:path] = p
  end

  opts.on("-v", "--verbose", "Run verbosely") do |v|
    options[:verbose] = v
  end
end.parse!

if options[:path].nil?
  raise OptionParser::MissingArgument.new(<<-MSG.squish)
    Path of the csv file missing.
    For more information use with -h option
  MSG
end
logger = options[:verbose] ? Logger.new(STDOUT) : nil

#INIT AR
require_relative '../config/database'

#REQUIRE MODEL
require_relative 'models/order_article'

#INIT PARSER
require_relative 'helpers/parser'
parser = Parser.new(options[:path], logger)
collection = parser.parse

#WRITE RESPONSE
require_relative 'helpers/persister'
persister = Persister.new(logger)
persister.persist_sql(collection)

puts "COMPLETED"