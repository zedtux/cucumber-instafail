require 'cucumber/formatter/console'
require 'cucumber/formatter/io'

module Cucumber
  module Formatter
    # The formatter used for <tt>--format progress-instafail</tt>
    class ProgressInstafail < Cucumber::Formatter::Progress
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
end
