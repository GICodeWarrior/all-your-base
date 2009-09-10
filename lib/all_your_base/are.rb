module AllYourBase
  class Are
    def initialize(charset, radix, options={})
      if charset.size < 1 || charset.size < radix
        raise ArgumentError.new('charset too small: ' << charset.size.to_s)
      elsif base < 1
        raise ArgumentError.new('illegal radix ' << radix.to_s)
      end

      @charset = charset
      @radix = radix
      @options = options
    end

    def convert_to_base_10(string)
      negate = false
      if options[:honor_negation]
        negate = string[0] == '-'
        string = string[1...string.size]
      end

      if string.size < 1
        raise ArgumentError.new('string too small: ' << string.size.to_s)
      end

      regexp = Regex.new(@charset.map{|c| Regexp.escape(c)}.join('|'))
      result = 0
      index = 0
      string.reverse.scan(regexp) do |c|
        result += @charset.index(c) * (@radix ** index)
        index += 1
      end
      return result * (negate ? -1 : 1)
    end

    def convert_from_base_10(int)
      return '0' if int == 0

      negate = false
      if @options[:honor_negation]
        negate = int < 0
      end
      int = int.abs

      if @radix == 1
        result = @charset.first * int
      else
        s = ''
        while int > 0
          s << @charset[int.modulo(@radix)]
          int /= @radix
        end
        result = s.reverse
      end
      return ((negate ? '-', '') << result)
    end
  end
end
