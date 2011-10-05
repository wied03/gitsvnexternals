module BWied
=begin rdoc
Represents a single SVN external declaration
=end
  class SvnExternal

    # The source path (where the external comes from)
    attr_reader :sourcePath

    # Where should the external be placed?
    attr_reader :destPath

    def initialize (srcPath, dstPath)
      @sourcePath = srcPath
      @destPath = dstPath
    end
  end
end