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
      lambda {ayb = AllYourBase::Are.new([],1)}.should raise_error(ArgumentError, 'charset too small 0')
    end
    it "should not allow radix of less than 1" do
      lambda {ayb = AllYourBase::Are.new(AllYourBase::Are::BASE_78_CHARSET,0)}.should raise_error(ArgumentError, 'illegal radix 0')
    end
    it "should set the charset instance variable" do
      ayb = AllYourBase::Are.new(AllYourBase::Are::BASE_78_CHARSET,78)
      ayb.instance_variable_get('@charset').should eql(AllYourBase::Are::BASE_78_CHARSET)
    end
    it "should set the radix instance variable" do
      ayb = AllYourBase::Are.new(AllYourBase::Are::BASE_78_CHARSET,12)
      ayb.instance_variable_get('@radix').should eql(12)
    end
    it "should set the options instance variable" do
      ayb = AllYourBase::Are.new(AllYourBase::Are::BASE_78_CHARSET,12, {:muffin => true})
      ayb.instance_variable_get('@options').should == {:muffin => true}
    end
    it "should default radix to size of charset" do
      ayb = AllYourBase::Are.new(AllYourBase::Are::BASE_78_CHARSET)
      ayb.instance_variable_get('@radix').should eql(78)
    end
    it "should not allow a char set with - when :honor_negation is set" do
      lambda {
        AllYourBase::Are.new(['a', 'y', 'b', '-'], 3, {:honor_negation => true})
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
        @ayb = AllYourBase::Are.new(AllYourBase::Are::BASE_62_CHARSET, 62, {:honor_negation => true})
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
    
  end
end
