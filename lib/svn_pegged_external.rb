class SvnPeggedExternal < SvnRevisionExternal
  # Which revision was the external pegged at
  attr_reader :pegRevision

  def initialize (srcPath, dstPath, rev, peggedRev)
    super (srcPath, dstPath, rev)
    @pegRevision = peggedRev
  end
end