#!/usr/bin/ruby

require 'rubygems'
require 'all_your_base/are/belong_to_us'

sections = ['Instance Methods', 'Class Methods', 'Fun Stuff!']

code = {'Instance Methods' =>
['  @ayb = AllYourBase::Are.new
  %w(foo bar muffin).map do |word|
    "#{word} in base 10 is: #{@ayb.convert_to_base_10(word)}"
  end',
'  %w(253394 227969 140676922357).map do |int|
    "#{int} from base 10 is: #{@ayb.convert_from_base_10(int)}"
  end'],

'Class Methods' =>
['  AllYourBase::Are.convert_to_base_10("foo")',
'  AllYourBase::Are.convert_from_base_10(140676922357)'],

'Fun Stuff!' =>
['  "foo".from_base_78.to_base_32',
'  100011.from_base_3.to_base_11',
'  "foo".from_base_56.from_base_7.to_base_8.to_base_72',
'  "Zero".from_base_57.from_base_12.to_base_13.to_base_50']}

sections.each do |s|
  print "\e[H\e[2J"
  puts "  # #{s}"
  puts
  code[s].each do |c|
    print c
    readline
    result = eval(c)
    if result.is_a?(Array)
      puts result.map{|r| "=> #{r}"}.join("\n")
    else
      puts "=> #{result.inspect}"
    end
    readline
  end
end
