module AllYourBase
  class Converter
    attr_reader :val, :from_base
    
    def initialize(val, from_base)
      @val = val
      @from_base = from_base
    end
  end
  
  module StringExtension
    
    def from_base_64
      AllYourBase::Converter.new self, 64
    end
  end
  
  def register(mod)
    AllYourBase::Converter.send :include, mod
  end
  module_function :register
end

module AllYourBase::To
  def to_base_10
    ayb = AllYourBase::Are.new(AllYourBase::Are::BASE_64_CHARSET)
    ayb.convert_to_base_10(@val)
  end
end
AllYourBase.register AllYourBase::To
