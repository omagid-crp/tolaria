module Tolaria

  def self.version
    Gem::Version.new "1.0.0.beta"
  end

  module VERSION
    MAJOR, MINOR, TINY, PRE = Tolaria.version.segments
    STRING = Tolaria.version.to_s
  end

end
