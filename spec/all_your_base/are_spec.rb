require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AllYourBase::Are do
  it "should have consistent value for BASE_62_CHARSET" do
    AllYourBase::Are::BASE_62_CHARSET.join(',').should eql("0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z")
  end
  it "should have consistent value for BASE_64_CHARSET" do
    AllYourBase::Are::BASE_64_CHARSET.join(',').should eql("A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,0,1,2,3,4,5,6,7,8,9,+,/")
  end
  it "should have consistent value for BASE_78_CHARSET" do
    AllYourBase::Are::BASE_78_CHARSET.join(',').should eql("0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,!,$,&,',(,),*,+,,,-,.,:,;,=,@,_")
  end

  describe "#initialize" do
    it "should not allow charsets less 1" do
      lambda {ayb = AllYourBase::Are.new([], {:radix =>1})}.should raise_error(ArgumentError, 'charset too small 0')
    end
    it "should not allow radix of less than 1" do
      lambda {ayb = AllYourBase::Are.new(AllYourBase::Are::BASE_78_CHARSET, {:radix =>0})}.should raise_error(ArgumentError, 'illegal radix 0')
    end
    it "should set the charset instance variable" do
      ayb = AllYourBase::Are.new(AllYourBase::Are::BASE_78_CHARSET, {:radix =>78})
      ayb.instance_variable_get('@charset').should eql(AllYourBase::Are::BASE_78_CHARSET)
    end
    it "should set the options instance variable" do
      ayb = AllYourBase::Are.new(AllYourBase::Are::BASE_78_CHARSET, {:radix => 12})
      ayb.instance_variable_get('@options').should == {:radix => 12}
    end
    it "should default radix to size of charset" do
      ayb = AllYourBase::Are.new(AllYourBase::Are::BASE_78_CHARSET)
      ayb.instance_variable_get('@options')[:radix].should eql(78)
    end
    it "should not allow a char set with - when :honor_negation is set" do
      lambda {
        AllYourBase::Are.new(['a', 'y', 'b', '-'], {:honor_negation => true})
      }.should raise_error(ArgumentError, '"-" is unsupported in charset when honor_negation is set')
    end
  end

  describe "#convert_to_base_10" do
    before(:each) do
      @ayb = AllYourBase::Are.new(AllYourBase::Are::BASE_78_CHARSET)
    end
    it "should raise error if string is too short" do
      lambda {@ayb.convert_to_base_10('')}.should raise_error(ArgumentError, 'string too small 0')
    end
    it "should return the base 10 conversion of string" do
      @ayb.convert_to_base_10('somebody_set_up_us_the_bomb').should eql(855149198991141649141572449638390201857110945891509)
    end
    describe "when honor_negation is true" do
      before(:each) do
        @ayb = AllYourBase::Are.new(AllYourBase::Are::BASE_62_CHARSET, {:honor_negation => true})
      end
      it "should raise error if string is too short" do
        lambda {@ayb.convert_to_base_10('-')}.should raise_error(ArgumentError, 'string too small 0')
      end
      it "should return a negative integer if string starts with a -" do
        @ayb.convert_to_base_10('-A').should eql(-10)
      end
      it "should return a positive integer if string does not start with a -" do
        @ayb.convert_to_base_10('A').should eql(10)
      end
    end
  end

  describe "#convert_from_base_10" do
    it "should return '0' if value is 0" do
      @ayb = AllYourBase::Are.new(AllYourBase::Are::BASE_78_CHARSET)
      @ayb.convert_from_base_10(0).should eql('0')
    end
    it "should return a string with a - at the beginning if value is negative and negation is honored" do
      @ayb = AllYourBase::Are.new(AllYourBase::Are::BASE_64_CHARSET, {:honor_negation => true})
      @ayb.convert_from_base_10(-100).should eql('-Bk')
    end
    it "should return value if radix is 1" do
      @ayb = AllYourBase::Are.new(AllYourBase::Are::BASE_64_CHARSET, {:radix =>1})
      @ayb.convert_from_base_10(11).should eql('AAAAAAAAAAA')
    end
    it "should return other value if radix is not 1" do
      @ayb = AllYourBase::Are.new(AllYourBase::Are::BASE_64_CHARSET,{:radix =>12})
      @ayb.convert_from_base_10(11).should eql('L')
    end
  end
  
  describe ".convert_to_base_10" do
    it "should allow you to convert to base 10 without initializing an instance of AllYourBase::Are" do
      result = AllYourBase::Are.convert_to_base_10('foo', AllYourBase::Are::BASE_64_CHARSET, {:radix => 11})
      result.should eql(4231)
    end
  end
  describe ".convert_from_base_10" do
    it "should allow you to convert from base 10 without initializing an instance of AllYourBase::Are" do
      result = AllYourBase::Are.convert_from_base_10(4231, AllYourBase::Are::BASE_64_CHARSET, {:radix => 11})
      result.should eql('DBKH')
    end
  end
end
