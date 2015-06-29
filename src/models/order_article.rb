class OrderArticle

  attr_accessor :id, :retoure_reason

  def initialize(params)
    params.each do |k, v|
      send("#{k}=", v)
    end
    normalize
  end

  #Use Arel to generate SQL
  def update_sql
    update_manager = Arel::UpdateManager.new(ActiveRecord::Base)
    update_manager.table(arel_table)
    update_manager.where(arel_table[:id].eq(id))
    update_manager.set([[arel_table[:retoure_reason], retoure_reason]])
    update_manager.to_sql
  end

  private
    def arel_table
      @table ||= Arel::Table.new(:order_article)
    end

    def normalize
      self.retoure_reason = retoure_reason.split(',').map do |reason|
        reason.split('/').map do |r|
          if r.to_i == 0
            normalize_string_reason(r)
          elsif r.to_i < 1000000
            normalize_int_reason(r)
          else
            [8]
          end
        end.flatten.join(',')
      end.flatten.join(',')
    end

    def normalize_int_reason(reason)
      ret = reason.split('').reverse_each.inject('') do |res, r|
        res = r + res
        res = ',' + res if r != '0'
        res
      end
      ret[1..ret.length]
    end

    #Returns x1,x2,x3,x4 and ignores the others
    def normalize_string_reason(reason)
      reason.scan(/(x[1-4])/)
    end

end