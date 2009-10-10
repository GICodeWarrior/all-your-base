require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AllYourBase::Converter do
  describe "#from_base_64" do
    it "should return the proper object type" do
      "foo".from_base_64.class.should eql(AllYourBase::Converter)
    end
    it "should return a Converter with the val and original base set" do
      converter = "foo".from_base_64
      converter.from_base.should eql(64)
      converter.val.should eql('foo')
    end
  end
  
  #describe "method_missing" do
  #  it "should allow me to use any base that we have specified in our config" do
  #    converter = "foo".from_base_78
  #  end
  #end
end