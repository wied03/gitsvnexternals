require "external_line_parser"

module BWied
=begin rdoc
Takes care of getting the externals for a particular directory and instantiating them
=end
  class ExternalLoader
    attr_reader :externals

    def initialize (gitWorkingCopyPath)
      Dir.chdir(gitWorkingCopyPath)
      output = `git svn show-externals`
      puts output
      @externals = []
    end
  end
end