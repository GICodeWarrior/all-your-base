#!/usr/bin/ruby

require 'rubygems'
require 'all_your_base/are/belong_to_us'

# Finds ways to convert from one string to another through four base
# conversions.
if ARGV.size != 2
  puts <<EOF
Usage: ruby brute.rb <from> <to>
Finds ways to convert "from" to "to" through four base conversions.

Example:
$ ruby brute.rb foo bar
'FOO' => 'BAR' -- [27, 9, 7, 53]
'foo' => 'BAR' -- [56, 7, 8, 72]
...

$ irb -r rubygems -r all_your_base/are/belong_to_us
irb(main):001:0> 'FOO'.from_base_27.from_base_9.to_base_7.to_base_53
=> "BAR"
EOF
  exit 1
end

def multi_case(s)
  a = ['']
  s.split(/\s*/).each do |c|
    a = a.map{|s| s + c.downcase} + a.map{|s| s + c.upcase}
  end
  return a
end

def valid_bases(s)
  max = 0
  s.split(/\s*/).each do |c|
    idx = AllYourBase::Are::BASE_78_CHARSET.index(c)
    max = idx if idx > max
  end
  return (max+1..78)
end

def conversions_of(i)
  list = multi_case(i).uniq
  results = []
  list.each do |s|
    valid_bases(s).each do |r|
      results << [s, r, s.send(:"from_base_#{r}")]
    end
  end
  return results
end

hello = conversions_of(ARGV[0])
world = conversions_of(ARGV[1])

hc = []
hello.map{|h| conversions_of(h.last.to_s)}.each{|r| hc += r}
hc.sort!{|a, b| a.last.to_i <=> b.last.to_i}

wc = []
world.map{|w| conversions_of(w.last.to_s)}.each{|r| wc += r}
wc.sort!{|a, b| a.last.to_i <=> b.last.to_i}

while !hc.empty? && !wc.empty? do
  h = hc.first
  w = wc.first
  if h.last == w.last
    lr = hello.select{|m| m.last.to_s == h.first.to_s}.first
    rr = world.select{|m| m.last.to_s == w.first.to_s}.first
    puts "'#{lr.first}' => '#{rr.first}' -- " \
         "[#{lr[1]}, #{h[1]}, #{w[1]}, #{rr[1]}]"
    hc.shift
    wc.shift
  elsif h.last.to_i < w.last.to_i
    hc.shift
  else
    wc.shift
  end
end

