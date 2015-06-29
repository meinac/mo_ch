class Persister
  OUTPUT_DIR = 'output'
  OUTPUT_FILE = [OUTPUT_DIR, 'output.sql'].join('/')

  def initialize(logger = nil)
    @logger = logger
    Dir.mkdir(OUTPUT_DIR) unless File.exists?(OUTPUT_DIR)
  end

  def persist_sql(collection)
    puts "GENERATING SQL"
    File.open(OUTPUT_FILE, 'w') do |f|
      collection.each do |order|
        sql = order.update_sql
        @logger << "#{sql}\n" if @logger
        f << "#{sql}\n"
      end
    end
    puts "SQL output inserted into #{File.expand_path("../..", File.dirname(__FILE__))}/#{OUTPUT_FILE}"
  end
end