class Parser

  def initialize(path, logger = nil)
    @path = path
    @logger = logger
  end

  def parse
    puts "PARSING CSV"
    csv = Roo::CSV.new(@path)
    columns = csv.first
    collection = []
    csv.drop(1).each do |row|
      hash = columns.each_with_index.inject({}) do |h, (c, i)|
        h.merge!(c => row[i])
      end
      @logger << "#{hash}\n" if @logger
      collection << OrderArticle.new(hash)
    end
    collection
  end

end