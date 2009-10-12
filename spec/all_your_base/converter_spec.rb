require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AllYourBase::Converter do
  describe "#from_base_64" do
    it "should return the proper object type" do
      "foo".from_base_64.class.should eql(AllYourBase::Converter)
    end
    it "should return a Converter with the val and original base set" do
      converter = "foo".from_base_64
      converter.from_base.should eql(64)
      converter.str.should eql('foo')
    end
  end
  
  describe "#to_s" do
    it "should be able to pretend as a string still" do
      "foo".from_base_64.to_s.should eql('foo')
      "foo".from_base_64.to_s.class.should eql(String)
    end
  end
  
  describe "method_missing" do
    it "should allow me to use any base" do
      converter = "foo".from_base_11
      converter.from_base.should eql(11)
      converter.str.should eql('foo')
    end
  end
  
  describe "#to_base_10" do
    it "should allow me to convert to base 10" do
      "foo".from_base_64.to_base_10.should eql(129576)
      "foo".from_base_62.to_base_10.should eql(160754)
    end
  end
  
end