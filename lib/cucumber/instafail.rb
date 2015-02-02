require 'cucumber/formatter/progress'
require 'cucumber/instafail/version'

module Cucumber
  # The formatter used for <tt>--format Cucumber::Instafail</tt>
  class Instafail < Cucumber::Formatter::Progress
    def progress(status)
      char = CHARS[status]
      @io.print(format_string(char, status))
      if status == :failed
        last_failed = runtime.steps(:failed).last
        print_elements(Array(last_failed), status, 'steps')
      end
      @io.flush
    end
  end
end
