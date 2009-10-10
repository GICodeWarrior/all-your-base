module AllYourBase
  class Converter
    attr_reader :val, :from_base
    
    def initialize(val, from_base)
      @val = val
      @from_base = from_base
    end
  end
  
  module StringExtension
    def method_missing(sym, *args, &block)
      if match = /from_base_([0-9])*/.match(sym.to_s)
        AllYourBase::Converter.new self, sym.to_s.split('_').last.to_i
      else
        super # NoMethodError
      end
    end
    
  end
  
  def register(mod)
    AllYourBase::Converter.send :include, mod
  end
  module_function :register
end

module AllYourBase::To
  def to_base_10
    base_charset = case @from_base
      when 62
        AllYourBase::Are::BASE_62_CHARSET
      when 64
        AllYourBase::Are::BASE_64_CHARSET
      when 78
        AllYourBase::Are::BASE_78_CHARSET
    end
    ayb = AllYourBase::Are.new(base_charset)
    ayb.convert_to_base_10(@val)
  end
end
AllYourBase.register AllYourBase::To
