module AllYourBase
  class Are
    # This charset works for "standard" bases 2-36 and 62.  It also provides
    # non-standard bases 1 and 37-61 for most uses.
    BASE_62_CHARSET = ('0'..'9').to_a + ('A'..'Z').to_a + ('a'..'z').to_a

    # This is the base64 encoding charset, but note that this library does not
    # provide true base64 encoding.
    BASE_64_CHARSET = ('A'..'Z').to_a + ('a'..'z').to_a + ('0'..'9').to_a +
                      ['+', '/']

    # This is a _maximum_ URL safe charset (between /'s).  Not all sites know
    # or care about the validity of these characters.
    BASE_78_CHARSET = BASE_62_CHARSET + ['!', '$', '&', "'", '(', ')', '*', '+',
                                         ',', '-', '.', ':', ';', '=', '@', '_']

    def initialize(charset, options={})
      options[:radix] ||= charset.size
      if charset.size < 1 || charset.size < options[:radix]
        raise ArgumentError.new('charset too small ' << charset.size.to_s)
      elsif options[:radix] < 1
        raise ArgumentError.new('illegal radix ' << options[:radix].to_s)
      elsif charset.include?('-') && options[:honor_negation]
        raise ArgumentError.new('"-" is unsupported in charset when honor_negation is set')
      end

      @charset = charset
      @options = options
    end

    def convert_to_base_10(string)
      negate = false
      if @options[:honor_negation]
        negate = string[0...1] == '-'
        string = string[1...string.size] if negate
      end

      if string.size < 1
        raise ArgumentError.new('string too small ' << string.size.to_s)
      end
      regexp = Regexp.new(@charset.map{|c| Regexp.escape(c)}.join('|'))
      result = 0
      index = 0
      string.reverse.scan(regexp) do |c|
        result += @charset.index(c) * (@options[:radix] ** index)
        index += 1
      end
      return result * (negate ? -1 : 1)
    end
    
    def self.convert_to_base_10(string, charset, options={})
      ayb = self.new(charset, options)
      ayb.convert_to_base_10(string)
    end
    
    def self.convert_from_base_10(int, charset, options={})
      ayb = self.new(charset, options)
      ayb.convert_from_base_10(int)
    end
    
    def convert_from_base_10(int)
      return '0' if int == 0

      negate = false
      if @options[:honor_negation]
        negate = int < 0
      end
      int = int.abs

      if @options[:radix] == 1
        result = @charset.first * int
      else
        s = ''
        while int > 0
          s << @charset[int.modulo(@options[:radix])]
          int /= @options[:radix]
        end
        result = s.reverse
      end
      return ((negate ? '-' : '') << result)
    end
  end
end
