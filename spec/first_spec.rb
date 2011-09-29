require "base_spec"
# TODO: How to get Rubymine to recognize the require magic I have in base_spec for syntax completion
require "svn_external"

describe "My behaviour" do

  it "should instantiate properly" do
    stuff = SvnExternal.new('the src', 'the dest')
    stuff.sourcePath.should == "the src"
    stuff.destPath.should == "the dest"
  end
end