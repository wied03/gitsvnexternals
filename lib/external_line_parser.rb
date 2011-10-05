module BWied
=begin rdoc
Parses externals file lines coming from GIT-SVN into usable information
=end
  class ExternalLineParser

    # The parsed external after parsing
    attr_reader :external

    # Parses a raw line of text from the GIT SVN externals implementation
    def initialize (externalsInputLine)
      @external = "blah"
    end

  end
end