module BWied
=begin rdoc
Represents "local externals", e.g. within the same working copy
=end
  class SvnLocalExternal < SvnExternal
    def initialize (srcPath, dstPath)
      super(srcPath,dstPath)
    end
  end
end