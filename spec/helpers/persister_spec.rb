describe Persister do

  # This should be before :each 
  # because rspec does not supports
  # stubing inside of before :all
  before(:each) do
    stub_const('Persister::OUTPUT_DIR', 'spec/output')
    stub_const('Persister::OUTPUT_FILE', 'spec/output/output.sql') # We should stub this too because It's value set at initialization step
  end

  after(:each) do
    FileUtils.rm_rf(Persister::OUTPUT_DIR)
  end

  context '#constuctor' do
    it 'should create the output directory if does not exist' do
      persister = Persister.new
      expect(Dir.exists?(Persister::OUTPUT_DIR)).to be_truthy
    end
  end

  context '#persist_sql' do
    before do
      @collection = 10.times.map do |i|
        OrderArticle.new({ id: i, retoure_reason: "i" })
      end  
    end

    it 'should persist sql' do
      persister = Persister.new
      silence_stream(STDOUT) { persister.persist_sql(@collection) }
      expect(File.exists?(Persister::OUTPUT_FILE)).to be_truthy
    end
  end

end