require "base_spec"
require "svn_external"

describe BWied::SvnExternal do

  it "should instantiate properly" do
    stuff = BWied::SvnExternal.new('the src', 'the dest')
    stuff.sourcePath.should == "the src"
    stuff.destPath.should == "the dest"
  end
end