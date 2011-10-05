require "base_spec"
require "external_line_parser"

describe BWied::ExternalLineParser do
  def instantiate
    @parser = BWied::ExternalLineParser.new(@line)
    @external = @parser.external
  end

  it "should work properly with a basic external" do
    # arrange
    @line = "/destrootPath/     http://www.some.host/path                            destSubDir
"
    # act
    instantiate

    # assert
    @external.sourcePath.should == "http://www.some.host/path"
    @external.destPath.should == "/destrootPath/destSubDir"
  end

  it "should work properly with a local external" do
    # arrange
    @line = "/NexusRefDataApp/     ../EventManager/NexusRefDataModel                            NexusRefDataModel
"
    # act
    instantiate

    # assert
    @external.sourcePath.should == "../EventManager/NexusRefDataModel"
    @external.destPath.should == "/NexusRefDataApp/NexusRefDataModel"

  end

  it "should work properly with a revision external (style 1)" do
    # arrange
    @line = "/full/destPath/here -r67 https://somehost.com/path
"
    # act
    instantiate

    # assert
    @external.sourcePath.should == "https://somehost.com/path"
    @external.destPath.should == "/full/destPath/here"
    @external.revision.should == "67"
  end

  it "should work properly with a revision external (style 2)" do
    # arrange
    @line = "/partDestPathHere/-r86 https://somehost.com/path restHere
"
    # act
    instantiate

    # assert
    @external.sourcePath.should == "https://somehost.com/path"
    @external.destPath.should == "/partDestPathHere/restHere"
    @external.revision.should == "86"
  end

  it "should work properly with a pegged external" do
    # arrange
    @line = "/somePath/-r86 https://somehost.com/path@79 restOfPath
"
    # act
    instantiate

    # assert
    @external.sourcePath.should == "https://somehost.com/path"
    @external.destPath.should ==  "/somePath/restOfPath"
    @external.revision.should == "86"
    @external.pegRevision.should == "79"
  end
end