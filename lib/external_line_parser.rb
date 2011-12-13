require "svn_external"
require "svn_local_external"
require "svn_revision_external"
require "svn_pegged_external"

module BWied
=begin rdoc
Parses externals file lines coming from GIT-SVN into usable information
=end
  class ExternalLineParser

    # The parsed external after parsing
    attr_reader :external

    # Parses a raw line of text from the GIT SVN externals implementation
    def initialize (externalsInputLine)
      @rawText=externalsInputLine
      @external = tryCommentedLine ? nil : tryBasicExternal || tryPeggedExternal ||tryRevisionExternal2 || tryRevisionExternal || tryLocalExternal
    end

    private

    def tryCommentedLine
      @rawText.match(/#.*/)
    end

    def tryBasicExternal
       matches = @rawText.match(/(\S+^[-r\d+])\s+((?:file:|http:|https:|svn:|svn\+ssh:)\S+)\s+(\S+)/)
       matches ? SvnExternal.new(matches[2], "#{matches[1]}#{matches[3]}") : nil
    end

    def tryLocalExternal
      matches = @rawText.match(/(\S+)\s+(\S+)\s+(\S+)/)
      matches ? SvnLocalExternal.new(matches[2], "#{matches[1]}#{matches[3]}") : nil
    end

    def tryRevisionExternal
      matches = @rawText.match(/(\S+)\s+-r(\d+)\s+((?:file:|http:|https:|svn:|svn\+ssh:)\S+)/)
      matches ? SvnRevisionExternal.new(matches[3], matches[1], matches[2]) : nil
    end

    def tryRevisionExternal2
      matches = @rawText.match(/(\S+)-r(\d+)\s+((?:file:|http:|https:|svn:|svn\+ssh:)\S+)\s+(\S+)/)
      matches ? SvnRevisionExternal.new(matches[3],"#{matches[1]}#{matches[4]}", matches[2]) : nil
    end

    def tryPeggedExternal
      matches = @rawText.match(/(\S+)-r(\d+)\s+((?:file:|http:|https:|svn:|svn\+ssh:)\S+)@(\d+)\s+(\S+)/)
      matches ? SvnPeggedExternal.new(matches[3],"#{matches[1]}#{matches[5]}", matches[2], matches[4]) : nil
    end

  end
end