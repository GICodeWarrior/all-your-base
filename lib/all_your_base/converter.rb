module AllYourBase
  class Converter
    attr_reader :str, :from_base
    
    def initialize(str, from_base)
      @str = str
      @from_base = from_base
    end
    
    def to_str
      @str
    end
    alias :to_s :to_str
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
    ayb.convert_to_base_10(@str)
  end
end
AllYourBase::Converter.send :include, AllYourBase::To
