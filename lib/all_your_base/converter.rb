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
      if sym.to_s.match(/\Afrom_base_([0-9]+)\Z/)
        AllYourBase::Converter.new self, $1.to_i
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
      else
        AllYourBase::Are::BASE_78_CHARSET[0...@from_base]
    end
    
    ayb = AllYourBase::Are.new(base_charset)
    ayb.convert_to_base_10(@val)
  end
end
AllYourBase.register AllYourBase::To
