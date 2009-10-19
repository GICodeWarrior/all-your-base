require 'all_your_base'

module AllYourBase
  class Are
    module BelongToUs
      module From
        def method_missing(sym, *args, &block)
          if sym.to_s.match(/\Afrom_base_([0-9]+)\Z/)
            AllYourBase::Are.convert_to_base_10(self.to_s, {:radix => $1.to_i})
          else
            super # NoMethodError
          end
        end
      end

      module To
        def method_missing(sym, *args, &block)
          if sym.to_s.match(/\Ato_base_([0-9]+)\Z/)
            AllYourBase::Are.convert_from_base_10(self.to_i, {:radix => $1.to_i})
          else
            super # NoMethodError
          end
        end
      end
    end
  end
end

String.send   :include, AllYourBase::Are::BelongToUs::From
String.send   :include, AllYourBase::Are::BelongToUs::To
Integer.send  :include, AllYourBase::Are::BelongToUs::From
Integer.send  :include, AllYourBase::Are::BelongToUs::To
