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
end