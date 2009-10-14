#!/usr/bin/ruby

require 'rubygems'
require 'all_your_base/are/belong_to_us'

code = [
'  # Instance Methods
  @ayb = AllYourBase::Are.new(AllYourBase::Are::BASE_78_CHARSET)
  %w(foo bar muffin).map do |word|
    "#{word} in base 10 is: #{@ayb.convert_to_base_10(word)}"
  end',
'  %w(253394 227969 140676922357).map do |int|
    "#{int} from base 10 is: #{@ayb.convert_from_base_10(int)}"
  end',
'  # Class Methods
  AllYourBase::Are.convert_to_base_10("foo", AllYourBase::Are::BASE_78_CHARSET)',
'  AllYourBase::Are.convert_from_base_10(140676922357, AllYourBase::Are::BASE_78_CHARSET)',
'  # Fun Stuff!
  "foo".from_base_78.to_base_32',
'  100011.from_base_10.to_base_11',
'  "foo".from_base_56.from_base_7.to_base_8.to_base_72']

code.each do |c|
  puts c
  readline
  result = eval(c)
  if result.is_a?(Array)
    result.each{|r| puts "=> #{r}"}
  else
    puts "=> #{result.inspect}"
  end
  readline
end
