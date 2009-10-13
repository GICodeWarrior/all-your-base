require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')
require 'all_your_base/are/belong_to_us'

describe AllYourBase::Are::BelongToUs::From do
  it "should convert string to base 10" do
    'foo'.from_base_61.should eql(155661)
  end

  it "should convert integer to base 10" do
    112233.from_base_61.should eql(858903732)
  end
  it "should raise if the base is over 78"
  it "should raise if the base is 0"
end
  
describe AllYourBase::Are::BelongToUs::To do
  it "should convert string from base 10" do
    '155661'.to_base_61.should eql('foo')
  end
  it "should convert integer from base 10" do
    155661.to_base_61.should eql('foo')
  end
  it "should raise if the base is over 78"
  it "should raise if the base is 0"
end

describe AllYourBase::Are::BelongToUs do
  it "should do complex conversions" do
    'foo'.from_base_64.to_base_14.should eql('46558')
  end
  it "should allow you to do stupid stuff" do
    'foo'.from_base_78.to_base_14.from_base_14.to_base_78.should eql('foo')
  end
end