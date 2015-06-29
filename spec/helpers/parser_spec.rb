require 'spec_helper'

describe Parser do

  context '#parse' do
    it 'should parse the csv and return order_article as a collection' do
      parser = Parser.new('spec/support/csv.csv')
      collection = silence_stream(STDOUT) { parser.parse }
      expect(collection.map(&:id)).to eql([
        '100594b0-4aed-9aa1-e381-52d02905c7a8', 
        '1009077b-110e-4010-b211-527137fdc0c2', 
        '100a77c5-b15f-b5df-5a67-5134fed5a219', 
        '100b0edd-f658-02e2-dac7-52d7eb5bcf8b', 
        '100bfbd8-61c7-939e-984d-52c6f72ee312', 
        '100c3488-a966-c40d-5099-52d532ff3903',
        '100c3488-a966-c40d-5099-52dm12fg3912'
      ])
      expect(collection.map(&:retoure_reason)).to eql(['8,10', '10,9,8', '1,4', 'x1', '10,8', 'x1,x2', 'x1,x2,1,x3'])
    end
  end

end