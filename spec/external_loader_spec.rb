require "base_spec"
require "external_loader"

describe BWied::ExternalLoader do

  it "it should work properly with the test working copy" do
    # arrange

    # act
    loader = BWied::ExternalLoader.new("/Users/brady/code/Ruby/gitsvnexternals/spec/gitsvncopy")

    # assert
    externals = loader.externals
    externals.count().should == 66
    ext = externals[0]
    ext.should be_instantiated_as BWied::SvnExternal
    ext.sourcePath.should == "svn://localhost/externalSrcDir"
    ext.destPath.should == "/basicExternalTest"

    ext = externals[1]
    ext.should be_instantiated_as BWied::SvnLocalExternal
    ext.sourcePath.should == "../externalSrcDir"
    ext.destPath.should == "/localExternalTest"

    ext = externals[2]
    ext.should be_instantiated_as BWied::SvnRevisionExternal
    ext.sourcePath.should == "../externalSrcDir"
    ext.destPath.should == "/revisionExternalTest"
    ext.revision.should == "1"

    ext = externals[3]
    ext.should be_instantiated_as BWied::SvnRevisionExternal
    ext.sourcePath.should == "svn://localhost/externalSrcDir"
    ext.destPath.should == "/revisionExternalTest"
    ext.revision.should == "1"

    ext = externals[4]
    ext.should be_instantiated_as BWied::SvnPeggedExternal
    ext.sourcePath.should == "svn://localhost/externalSrcDir"
    ext.destPath.should == "/revisionExternalTest"
    ext.revision.should == "1"
    ext.pegRevision.should == "1"
  end
end