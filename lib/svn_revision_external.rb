module BWied
  class SvnRevisionExternal < SvnExternal
    # Which revision from the source path should be used (will be a number, not -rXXX)
    attr_reader :revision

    def initialize (srcPath, dstPath, rev)
      super(srcPath, dstPath)
      @revision = rev
    end

  end
end