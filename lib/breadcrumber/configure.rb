module Breadcrumber
  module Configure
    @@truncate_length = 20
    @@truncate_separator = " "

    def configure(*config)
      yield self if block_given?
    end

    def truncate_length
      @@truncate_length
    end

    def truncate_length=(length)
      @@truncate_length = length
    end

    def truncate_separator
      @@truncate_separator
    end

    def truncate_separator=(separator)
      @@truncate_separator = separator
    end
  end
end