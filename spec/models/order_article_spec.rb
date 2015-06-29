require 'spec_helper'

describe OrderArticle do

  before(:all) do
    @order_article = OrderArticle.new({ id: 1, retoure_reason: '1' })
  end

  context '#constructor' do
    it 'should initialize object with given Hash' do
      o = OrderArticle.new({ id: 1, retoure_reason: '1' })
      expect(o.id).to eql(1)
      expect(o.retoure_reason).to eql('1')
    end

    it 'should normalize reason with #normalize' do
      o = OrderArticle.new({ id: 1, retoure_reason: 'x1,x2,x3,x4' })
      expect(o.retoure_reason).to eql('x1,x2,x3,x4')

      o = OrderArticle.new({ id: 1, retoure_reason: '1,2,3,4,5,6,7,8,9,10' })
      expect(o.retoure_reason).to eql('1,2,3,4,5,6,7,8,9,10')

      o = OrderArticle.new({ id: 1, retoure_reason: 'x1x2' })
      expect(o.retoure_reason).to eql('x1,x2')

      o = OrderArticle.new({ id: 1, retoure_reason: '810' })
      expect(o.retoure_reason).to eql('8,10')

      o = OrderArticle.new({ id: 1, retoure_reason: '810/10' })
      expect(o.retoure_reason).to eql('8,10,10')

      o = OrderArticle.new({ id: 1, retoure_reason: '810/10,9' })
      expect(o.retoure_reason).to eql('8,10,10,9')

      o = OrderArticle.new({ id: 1, retoure_reason: '1000000000000' })
      expect(o.retoure_reason).to eql('8')

      o = OrderArticle.new({ id: 1, retoure_reason: 'x1,6,1910,1000000000' })
      expect(o.retoure_reason).to eql('x1,6,1,9,10,8')
    end
  end

  context '#update_sql' do
    it 'should return update sql for the order_article' do
      expect(@order_article.update_sql).to eql('UPDATE "order_article" SET "retoure_reason" = \'1\' WHERE "order_article"."id" = 1')
    end
  end

end